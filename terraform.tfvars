# If you have multiple variable definitions file (*.tfvars) file, you can manually define 
# the file to use during command line. -var-file flag is used to specify the variable definitions file.
# Here is an example :  terraform apply -var-file="terraform.tfvars"
# It's very useful when you want to maintain multiple environments like dev, staging, production etc.
# But if the file is named terraform.tfvars or terraform.tfvars.json,
# Terraform automatically loads it, so you don't need to specify it with -var-file flag.

region        = "ca-central-1"

azs           = ["us-east-1", "ca-central-1"]

private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

intra_subnets = ["10.123.5.0/24", "10.123.6.0/24"]