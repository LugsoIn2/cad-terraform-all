output "cluster_id" {
    value = module.eks.cluster_id
}
output "cluster_endpoint" {
    value = module.eks.cluster_endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = data.aws_eks_cluster.default.certificate_authority.0.data
  #value = module.eks.cluster_certificate_authority_data
} 