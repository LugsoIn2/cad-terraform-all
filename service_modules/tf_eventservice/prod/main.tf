resource "helm_release" "eventservice" {
  name       = "${var.release_name_and_namespace_k8s_eventservice}-eventservice"
  chart      = "../helm/eventservice"
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
    value = replace("${var.allowed_hosts_eventservice}", ",", "\\,")
  }
  namespace = var.release_name_and_namespace_k8s_eventservice
  create_namespace = true
  dependency_update = true
}