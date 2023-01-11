data "http" "ingress_nginx_manifestfile" {
  url = "https://raw.githubusercontent.com/kubernetes/ingress-nginx/${var.ingess_manifest_version}/deploy/static/provider/aws/deploy.yaml"
}

# split raw yaml into individual resources
data "kubectl_file_documents" "ingress_nginx_manifest_split" {
  content = data.http.ingress_nginx_manifestfile.body
  depends_on = [
    data.http.ingress_nginx_manifestfile
  ]
}

# apply each resource from the yaml
resource "kubectl_manifest" "ingress_nginx_resource" {
  depends_on = [module.eks, data.kubectl_file_documents.ingress_nginx_manifest_split]
  for_each   = data.kubectl_file_documents.ingress_nginx_manifest_split.manifests
  yaml_body  = each.value
}








