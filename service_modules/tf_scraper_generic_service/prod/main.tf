# locals {
#   lower_scraper_name = lower("${var.scraper_scraper_name}")
# }
resource "helm_release" "scraper_generic_service" {
  name       = "${var.release_name_namespace_k8s_scraper_generic_service}-scraper-service-google"
  chart      = "../helm/scraper-generic-service"
  set {
    name  = "env.secret.AWS_ACCESS_KEY"
    value = var.aws_db_user_access_key
  }
  set {
    name  = "env.secret.AWS_SECRET"
    value = var.aws_db_user_secret_key
  }
  set {
    name  = "env.secret.CITIES"
    value = "${var.scraper_cities}"
  }
  set {
    name  = "env.secret.CMD_EXEC"
    value = "http://${var.scraper_cronjob_seleniumDNSname}:${var.scraper_cronjob_seleniumPort}/wd/hub"
  }
  set {
    name  = "env.secret.EV_TABLE_NAME"
    value = var.scraper_ev_table_name
  }
  set {
    name  = "env.secret.TEN_TABLE_NAME"
    value = var.scraper_ten_table_name
  }
  set {
    name  = "env.cronjob.schedule"
    value = var.scraper_cronjob_schedule
  }
  set {
    name  = "env.cronjob.seleniumDNSname"
    value = var.scraper_cronjob_seleniumDNSname
  }
  set {
    name  = "env.cronjob.seleniumPort"
    value = var.scraper_cronjob_seleniumPort
  }
  set {
    name  = "env.secret.SCRAPER_NAME"
    value = "${var.scraper_scraper_name}"
  }
  namespace = var.release_name_namespace_k8s_scraper_generic_service
  create_namespace = true
  dependency_update = true
}