# EKS Cluster Demo (Terraform)

Ce dépôt contient une infrastructure **AWS EKS** complète, provisionnée avec **Terraform**, basée sur les modules officiels `terraform-aws-modules`.

L’infrastructure inclut :
- Un **VPC** avec subnets publics / privés / intra
- Un **cluster EKS** (Kubernetes 1.29)
- Un **Managed Node Group**
- Les **addons EKS gérés par AWS** (CoreDNS, kube-proxy, VPC CNI)

---

##  Architecture

- **VPC**
  - Subnets publics (Load Balancers)
  - Subnets privés (Nodes EKS)
  - Subnets intra (Control Plane EKS)
  - NAT Gateway (single)

- **EKS**
  - Endpoint public activé
  - Managed Node Group
  - Addons :
    - CoreDNS
    - kube-proxy
    - vpc-cni

---

##  Prérequis

- Terraform ≥ 1.5
- AWS CLI configuré (`aws configure`)
- Un compte AWS avec les droits nécessaires (EKS, EC2, VPC, IAM)

---

##  Versions utilisées

- Terraform AWS Provider : `~> 5.79`
- Module VPC : `terraform-aws-modules/vpc/aws ~> 5.0`
- Module EKS : `terraform-aws-modules/eks/aws ~> 20.0`
- Kubernetes : **1.29**

---

##  Structure du projet

```

.
├── alias-kubernetes.md
├── demo-module-eks.tf
├── LICENSE
├── output.tf
├── README.md
├── terraform.tfvars
└── variables.tf

````

---

## Configuration

Créer un fichier `terraform.tfvars` à partir de l’exemple :

```hcl
region = "eu-west-1"

vpc-cidr = "10.0.0.0/16"

azs = ["eu-west-1a", "eu-west-1b"]

private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
intra_subnets   = ["10.0.201.0/24", "10.0.202.0/24"]
````

---

## Déploiement

Initialiser Terraform :

```bash
terraform init
```

Vérifier le plan :

```bash
terraform plan
```

Appliquer l’infrastructure :

```bash
terraform apply
```

---

##  Outputs

Une fois le déploiement terminé, Terraform expose :

* `cluster_name`
* `cluster_endpoint`

Pour les afficher :

```bash
terraform output
```

---

##  Connexion au cluster EKS

Mettre à jour le kubeconfig :

```bash
aws eks update-kubeconfig \
  --region <region> \
  --name <cluster_name>
```

Puis tester :

```bash
kubectl get nodes
```

---

##  Notes

* Ce projet est conçu comme un **demo / environnement de test**
* Les instances utilisées sont volontairement petites (`t3.micro`)
* Pour un environnement production :

  * endpoint privé
  * logging EKS
  * IRSA
  * monitoring (CloudWatch / Prometheus)

---



