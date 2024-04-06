terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.27.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = var.EKS-Cluster-Endpoint
  cluster_ca_certificate = base64decode(var.EKS-Cluster-Certificate)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.EKS-Cluster-Name]
    command     = "aws"
  }
}

provider "helm" {
  kubernetes {
    host                   = var.EKS-Cluster-Endpoint
    cluster_ca_certificate = base64decode(var.EKS-Cluster-Certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", var.EKS-Cluster-Name]
      command     = "aws"
    }
  }
}
