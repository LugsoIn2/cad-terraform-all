terraform {
    backend "s3" {
     bucket         = "cad-terraform-state-service"
     key            = "terraform.tfstate"
     region         = "eu-central-1"
     dynamodb_table = "terraform_state"
   }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}

provider "aws" {
    profile = ""
    region = "eu-central-1"
    access_key = var.access_key
    secret_key = var.secret_key
}

data "aws_eks_cluster" "eks-cad-event-cluster" {
  name = "CAD-Event"
}

data "aws_eks_cluster_auth" "eks-cad-event-cluster-auth" {
  name = "CAD-Event"
}
provider "helm" {
  # for test on local Kubernetes Cluster path to config
  # kubernetes {
  #   config_path = "~/.kube/config"
  #   config_context = "docker-desktop"
  # }
  kubernetes {
    host                   = data.aws_eks_cluster.eks-cad-event-cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-cad-event-cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks-cad-event-cluster-auth.token
  }
}
