resource "helm_release" "adminservice" {
  name       = "${var.release_name_and_namespace_k8s_adminservice}-adminservice"
  chart      = "./../helm/adminservice"
  #values     = ["./../../../../helm/adminservice/values.yaml"]
  set {
    name  = "env.secret.AWS_ACCESS_KEY"
    value = var.aws_db_user_access_key
  }
  set {
    name  = "env.secret.AWS_SECRET"
    value = var.aws_db_user_secret_key
  }
  set {
    name  = "env.secret.TF_VAR_access_key"
    value = var.aws_tf_user_access_key
  }
  set {
    name  = "env.secret.TF_VAR_secret_key"
    value = var.aws_tf_user_secret_key
  }
  set {
    name  = "env.secret.TF_VAR_aws_db_user_eventservice_access_key"
    value = var.aws_db_user_eventservice_access_key
  }
  set {
    name  = "env.secret.TF_VAR_aws_db_user_eventservice_secret_key"
    value = var.aws_db_user_eventservice_secret_key
  }
  set {
    name  = "env.secret.TF_VAR_gh_token"
    value = var.gh_token_ui_repos
  }
  set {
    name  = "env.secret.TF_VAR_aws_db_user_scraper_generic_access_key"
    value = var.aws_db_user_scraper_generic_access_key
  }
  set {
    name  = "env.secret.TF_VAR_aws_db_user_scraper_generic_secret_key"
    value = var.aws_db_user_scraper_generic_secret_key
  }
  set {
    name  = "env.secret.ALLOWED_HOSTS"
    value = replace("${var.allowed_hosts_adminservice}", ",", "\\,")
  }
  set {
    name  = "env.secret.ADMINTABLE_ENDPOINT"
    value = var.adminservicetable_endpoint
  }
  set {
    name  = "env.secret.DBNAME"
    value = var.admindb_name
  }
  set {
    name  = "env.secret.DB_USERNAME"
    value = var.admindb_username
  }
  set {
    name  = "env.secret.DB_PASSWORD"
    value = var.admindb_password
  }
  set {
    name  = "env.secret.TEN_TABLE_NAME"
    value = var.ten_table_name
  }

  namespace = var.release_name_and_namespace_k8s_adminservice
  create_namespace = true
  #dependency_update = true
}