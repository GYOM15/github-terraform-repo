provider "aws" {
  region = var.region
}


locals {
  name = "psr0-eks-cluster-demo"
  tags = {
    Example = local.name
  }
}


module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "~> 5.0"

    name = local.name
    cidr = var.vpc-cidr

    azs             = var.azs
    private_subnets = var.private_subnets
    public_subnets  = var.public_subnets
    intra_subnets   = var.intra_subnets

    enable_nat_gateway = true
    single_nat_gateway = true

    public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
    }

    private_subnet_tags = {
        "kubernetes.io/role/internal-elb" = 1
    }

}

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~>20.0"

  cluster_name    = local.name
  cluster_version = "1.29"

  # Me permet de gerer mon cluster depuis même mon laptop
  cluster_endpoint_public_access = true

  # Ceci permet d'installer les addons gérés par AWS EKS automatiquement
  cluster_addons = {
    # DNS → les pods se trouvent entre eux
    coredns = { 
      most_recent = true
    }
    # réseau interne Kubernetes
    kube-proxy = {
      most_recent = true
    }

    # donne une IP AWS à chaque pod
    vpc-cni = {
      most_recent = true
    }
  }

  # Connexion du cluster EKS au VPC
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # C’est où AWS place le control plane EKS.
  control_plane_subnet_ids = module.vpc.intra_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64" # Amazon Linux 2 optimisé pour EKS (OS des nodes)
    instance_types = ["t3.micro"] # Type d'instance EC2 pour les nodes

    attach_cluster_primary_security_group = true # Permet aux nodes de communiquer avec le control plane
  }



  # les noeuds gérés par EKS
  eks_managed_node_groups = {
    default = {
      desired_size = 1
      max_size     = 2
      min_size     = 1

      instance_types = ["t3.micro"]
    }
  }

  tags = local.tags
}





