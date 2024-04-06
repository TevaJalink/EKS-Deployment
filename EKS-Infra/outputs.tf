output "EKS-Cluster-Name" {
  value       = aws_eks_cluster.EKS-Cluster.name
  description = "Cluster name"
}

output "EKS-Cluster-Endpoint" {
  value       = aws_eks_cluster.EKS-Cluster.endpoint
  sensitive   = true
  description = "Cluster endpoints"
}

output "EKS-Cluster-certificate" {
  value       = aws_eks_cluster.EKS-Cluster.certificate_authority.0.data
  sensitive   = true
  description = "EKS cluster certificate used for authenticating the helm and kubernetes providers"
}

output "ECR-URL" {
  value       = aws_ecr_repository.prod-ecr.repository_url
  sensitive   = true
  description = "ECR URL used for the image storing and pulling"
}

output "EKS-oidc-Issuer" {
  value       = aws_eks_cluster.EKS-Cluster.identity[0].oidc[0].issuer
  description = "The oidc issuer of the eks cluster used for IAM authentication"
}