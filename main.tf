module "EKS-Infra" {
  source = "./EKS-Infra"

  aws_region            = "us-east-1"
  VPC_Name              = "EKS_VPC"
  VPC_CIDR_Block        = "10.0.0.0/16"
  Private_Subnets       = ["10.0.0.0/24", "10.0.1.0/24"]
  Public_Subnets        = ["10.0.100.0/24", "10.0.101.0/24"]
  Availability_Zones    = ["us-east-1a", "us-east-1b"]
  cluster_name          = "EKS-Cluster"
  Internet_Gateway_Name = "Internet_Gateway"
  Nat_Gateway_Name      = "nat gateway"
  ecr_name              = "prod-ecr"
}

module "EKS-Nginx-Resources" {
  source = "./EKS-Nginx-Resources"

  EKS-Cluster-Name        = module.EKS-Infra.EKS-Cluster-Name
  EKS-Cluster-Endpoint    = module.EKS-Infra.EKS-Cluster-Endpoint
  EKS-Cluster-Certificate = module.EKS-Infra.EKS-Cluster-certificate
  Repo-URL                = module.EKS-Infra.ECR-URL
  EKS-oidc-Issuer         = module.EKS-Infra.EKS-oidc-Issuer
}