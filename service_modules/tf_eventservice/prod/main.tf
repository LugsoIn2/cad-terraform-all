resource "helm_release" "eventservice" {
  name       = var.release_name_and_namespace_k8s_eventservice
  chart      = "../helm/prod"
  set {
    name  = "eventservice.env.secret.AWS_ACCESS_KEY"
    value = var.access_key
  }
  set {
    name  = "eventservice.env.secret.AWS_SECRET"
    value = var.secret_key
  }
  set {
    name  = "eventservice.env.secret.ALLOWED_HOSTS"
    value = replace("${var.allowed_hosts_eventservice}", ",", "\\,")
  }
  namespace = var.release_name_and_namespace_k8s_eventservice
  create_namespace = true
  dependency_update = true
}