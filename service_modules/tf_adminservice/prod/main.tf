resource "helm_release" "adminservice" {
  name       = "${var.release_name_and_namespace_k8s_adminservice}-adminservice"
  chart      = "../helm/adminservice"
  set {
    name  = "env.secret.AWS_ACCESS_KEY"
    value = var.access_key
  }
  set {
    name  = "env.secret.AWS_SECRET"
    value = var.secret_key
  }
  set {
    name  = "env.secret.ALLOWED_HOSTS"
    value = replace("${var.allowed_hosts_adminservice}", ",", "\\,")
  }
  # set {
  #   name  = "env.secret.ADMINTABLE_ENDPOINT"
  #   value = var.adminservicetable_endpoint
  # }
  namespace = var.release_name_and_namespace_k8s_adminservice
  create_namespace = true
  dependency_update = true
}