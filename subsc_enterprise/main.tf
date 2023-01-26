locals {
 enterprise_ev_table_name = "${terraform.workspace}_event_table"
 prod_tenant_table_name = "prod_tenants"
 dbuser_eventservice_key = module.create_eventservice_user.iam_access_key
 dbuser_eventservice_secret = module.create_eventservice_user.iam_secret_key
 dbuser_scraperservice_key = module.create_scraperservice_user.iam_access_key
 dbuser_scraperservice_secret = module.create_scraperservice_user.iam_secret_key
}

module "enterprise-userservice" {
  source = "./../sub_modules/service_modules/tf_userservice/prod/"
  bucket_name_userservice = "userservice"
  tags_userservice = {
      "Environment" = "Subscription_Enterprise"
      "Customer" = "${terraform.workspace}"
    }
  dist_assets_directory_userservice = "../local_helper/tmp_${terraform.workspace}_userservice/dist/assets"
  dist_directory_userservice = "../local_helper/tmp_${terraform.workspace}_userservice/dist"
  backend_servicename_userservice = "eventservice"
  gh_token = var.gh_token
}
module "enterprise-eventservice" {
  source = "./../sub_modules/service_modules/tf_eventservice/prod/"
  release_name_and_namespace_k8s_eventservice = terraform.workspace
  allowed_hosts_eventservice = "${terraform.workspace}-eventservice.aws.netpy.de"
  ev_table_name = local.enterprise_ev_table_name
  aws_db_user_access_key = local.dbuser_eventservice_key
  aws_db_user_secret_key = local.dbuser_eventservice_secret
}
module "enterprise-event-table" {
  source = "./../sub_modules/service_modules/tf_eventtableservice/prod"
  dbname = local.enterprise_ev_table_name
  tags_eventtable-database = {
      "Environment" = "Subscription_Enterprise"
      "Customer" = "${terraform.workspace}"
    }
}
module "subc-enterprise-scraper-selenium-service" {
  source = "./../sub_modules/service_modules/tf_scraper_selenium_service/prod/"
  release_name_namespace_k8s_scraper_selenium_service = terraform.workspace
}
module "subc-enterprise-scraper-generic-service" {
  source = "./../sub_modules/service_modules/tf_scraper_generic_service/prod/"
  aws_db_user_access_key = local.dbuser_scraperservice_key
  aws_db_user_secret_key = local.dbuser_scraperservice_secret
  release_name_namespace_k8s_scraper_generic_service = terraform.workspace
  scraper_ev_table_name = local.enterprise_ev_table_name
  scraper_ten_table_name = local.prod_tenant_table_name
  scraper_cronjob_schedule = "0/15 * * * *"
  scraper_cronjob_seleniumDNSname = "${terraform.workspace}-scraper-selenium-service.${terraform.workspace}.svc.cluster.local"
  scraper_cities = var.scraper_cities
}