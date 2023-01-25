terraform {
    backend "s3" {
     bucket         = "cad-terraform-state-service"
     key            = "terraform.tfstate"
     region         = "eu-central-1"
     dynamodb_table = "terraform_state"
   }
  required_providers {
    #required_version = ">= 0.13"
    aws = {
      source = "hashicorp/aws"
      version = "4.48.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "aws" {
    profile = ""
    region = "eu-central-1"
    access_key = var.access_key
    secret_key = var.secret_key
}
provider "helm" {
  kubernetes {
    #config_path = "~/.kube/config"
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.default.token
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.default.token
}

provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.default.token
  load_config_file       = false
}