resource "helm_release" "scraper_selenium_service" {
  name       = "${var.release_name_namespace_k8s_scraper_selenium_service}-scraper-selenium-service"
  chart      = "../../helm/scraper-selenium-service"
  namespace = var.release_name_namespace_k8s_scraper_selenium_service
  create_namespace = true
  dependency_update = true
}