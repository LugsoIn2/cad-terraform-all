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

# NameSpace
resource "kubectl_manifest" "ingress_nginx_resource_namespace" {
  depends_on = [module.eks, data.kubectl_file_documents.ingress_nginx_manifest_split]
  yaml_body   = lookup(data.kubectl_file_documents.ingress_nginx_manifest_split.manifests, "/api/v1/namespaces/ingress-nginx", "")
}

# Each manifest after namespace
resource "kubectl_manifest" "ingress_nginx_resource_other" {
  depends_on = [resource.kubectl_manifest.ingress_nginx_resource_namespace]
  for_each   = data.kubectl_file_documents.ingress_nginx_manifest_split.manifests
  yaml_body  = each.value
}









