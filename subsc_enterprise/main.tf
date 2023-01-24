locals {
 prod_ev_table_name = "${terraform.workspace}_event_table"
}

module "enterprise-userservice" {
  source = "./../service_modules/tf_userservice/prod/"
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
  source = "./../service_modules/tf_eventservice/prod/"
  release_name_and_namespace_k8s_eventservice = terraform.workspace
  allowed_hosts_eventservice = "${terraform.workspace}-eventservice.aws.netpy.de"
  ev_table_name = local.prod_ev_table_name
  aws_db_user_access_key = var.aws_db_user_eventservice_access_key
  aws_db_user_secret_key = var.aws_db_user_eventservice_secret_key
}
module "enterprise-event-table" {
  source = "./../service_modules/tf_eventtableservice/prod"
  dbname = local.prod_ev_table_name
  tags_eventtable-database = {
      "Environment" = "Subscription_Enterprise"
      "Customer" = "${terraform.workspace}"
    }
}
module "subc-enterprise-scraper-selenium-service" {
  source = "./../service_modules/tf_scraper_selenium_service/prod/"
  release_name_namespace_k8s_scraper_selenium_service = terraform.workspace
}
