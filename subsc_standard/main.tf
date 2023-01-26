locals {
 prod_ev_table_name = "prod_event_table"
 prod_tenant_table_name = "prod_tenants"
 dbuser_scraperservice_key = module.create_scraperservice_user.iam_access_key
 dbuser_scraperservice_secret = module.create_scraperservice_user.iam_secret_key
}
module "subc-standard-scraper-selenium-service" {
  source = "./../sub_modules/service_modules/tf_scraper_selenium_service/prod/"
  release_name_namespace_k8s_scraper_selenium_service = terraform.workspace
}
module "subc-standard-scraper-generic-service" {
  source = "./../sub_modules/service_modules/tf_scraper_generic_service/prod/"
  aws_db_user_access_key = local.dbuser_scraperservice_key
  aws_db_user_secret_key = local.dbuser_scraperservice_key
  release_name_namespace_k8s_scraper_generic_service = terraform.workspace
  scraper_ev_table_name = local.prod_ev_table_name
  scraper_ten_table_name = local.prod_tenant_table_name
  scraper_cronjob_schedule = "0 */1 * * *"
  scraper_cronjob_seleniumDNSname = "${terraform.workspace}-scraper-selenium-service.${terraform.workspace}.svc.cluster.local"
  scraper_cities = var.scraper_cities
}
