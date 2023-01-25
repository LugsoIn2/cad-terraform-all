resource "helm_release" "external-dns" {
  name       = "external-dns"
  chart      = "../../helm/external-dns"
  set {
    name  = "eksToRoute53rolearn"
    value = aws_iam_role.eks-to-route53.arn
  }
  set {
    name  = "domainname"
    value = var.domainname_external_dns
  }
  set {
    name  = "hostedzoneid"
    value = var.hostedzoneid_external_dns
  }
  namespace = "kube-system"
  #create_namespace = true
  #dependency_update = true
  depends_on = [
    aws_iam_role.eks-to-route53
  ]
}