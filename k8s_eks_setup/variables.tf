variable "map_aws_eks_auth_iam_users" {
  description = "Map the IAM Users as k8s System Masters"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "ingess_manifest_version" {
  description = "version of the nginx ingress manifest https://kubernetes.github.io/ingress-nginx/deploy/#cloud-deployments"
  type = string
  default = "controller-v1.5.1"
}

variable "domainname_external_dns" {
  description = "Domain name from Route53"
  type = string
}

variable "hostedzoneid_external_dns" {
  description = "Hosted Zone ID from Route53"
  type = string
}