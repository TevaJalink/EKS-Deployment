variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "EKS-Cluster-Endpoint" {
  type        = string
  description = "required variable, passed from the eks-infra module"
}

variable "EKS-Cluster-Name" {
  type        = string
  default     = "EKS-Cluster"
  description = "EKS cluster name, if not mentioned set to same defualt as EKS-Infra module"
}

variable "EKS-Cluster-Certificate" {
  type        = string
  description = "EKS Certificates used by the helm provider"
}

variable "Repo-URL" {
  type        = string
  description = "Requires the ECR URL from EKS-Infra module"
}

variable "EKS-oidc-Issuer" {
  type        = string
  description = "EKS oidc issuer"
}
