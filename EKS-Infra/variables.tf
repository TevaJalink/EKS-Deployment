variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region where the infrastructure will be deployed"
}

variable "cluster_name" {
  type        = string
  default     = "EKS-Cluster"
  description = "The EKS cluster name (needs to be uniqe)"
}

variable "VPC_Name" {
  type        = string
  default     = "EKS_VPC"
  description = "The AWS VPC name"
}

variable "VPC_CIDR_Block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPC Cidr block"
}

variable "Private_Subnets" {
  type        = list(any)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
  description = "Private subnets cidr block"
}

variable "Public_Subnets" {
  type        = list(any)
  default     = ["10.0.100.0/24", "10.0.101.0/24"]
  description = "Public subnets cidr block"
}

variable "Availability_Zones" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}

variable "Internet_Gateway_Name" {
  type        = string
  default     = "Internet_Gateway"
  description = "The name given to the internet gateway"
}

variable "Nat_Gateway_Name" {
  type        = string
  default     = "nat gateway"
  description = "Nat Gateway Name"
}

variable "ecr_name" {
  type        = string
  default     = "prod-ecr"
  description = "The name used for the ECR repository"
}