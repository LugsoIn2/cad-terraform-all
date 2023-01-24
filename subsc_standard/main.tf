module "subc-standard-scraper-selenium-service" {
  source = "./../service_modules/tf_scraper_selenium_service/prod/"
  release_name_namespace_k8s_scraper_selenium_service = terraform.workspace
}

