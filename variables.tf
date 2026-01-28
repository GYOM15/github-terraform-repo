variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "ca-central-1"
}

variable "azs" {
    description = "List of availability zones"
    type        = list(string)
    default     = ["us-east-1", "ca-central-1"]
}

variable "private_subnets" {
    description = "List of public subnet CIDR blocks"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
    description = "List of private subnet CIDR blocks"
    type        = list(string)
    default     = ["10.0.101.0/24", "10.0.102.0/24"]  
}

variable "intra_subnets" {
    description = "List of intra subnet CIDR blocks"
    type        = list(string)
    default     = ["10.123.5.0/24", "10.123.6.0/24"]
}

variable "vpc-cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

