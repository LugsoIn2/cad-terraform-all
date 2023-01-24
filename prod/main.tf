locals {
 prod_ev_table_name = "${terraform.workspace}_event_table"
 prod_admindb_name = "${terraform.workspace}_admintable"
 prod_tenant_table_name = "${terraform.workspace}_tenants"
}

module "prod-userservice" {
  source = "./../service_modules/tf_userservice/prod/"
  bucket_name_userservice = "userservice"
  tags_userservice = {
      "Environment" = "Prod"
    }
  dist_assets_directory_userservice = "../local_helper/tmp_${terraform.workspace}_userservice/dist/assets"
  dist_directory_userservice = "../local_helper/tmp_${terraform.workspace}_userservice/dist"
  backend_servicename_userservice = "eventservice"
  gh_token = var.gh_token
}

module "prod-adm-ui-service" {
  source = "./../service_modules/tf_adm_ui_service/prod/"
  dist_assets_directory_adm_ui_service = "../local_helper/tmp_${terraform.workspace}_admin_ui/dist/assets"
  dist_directory_adm_ui_service = "../local_helper/tmp_${terraform.workspace}_admin_ui/dist"
  bucket_name_adm_ui_service = "adm-ui-service"
  tags_adm_ui_service = {
    "Environment" = "Prod"
  }
  backend_servicename_adm_ui_service = "adminservice"
  gh_token = var.gh_token
}
module "prod-eventservice" {
  source = "./../service_modules/tf_eventservice/prod/"
  release_name_and_namespace_k8s_eventservice = terraform.workspace
  allowed_hosts_eventservice = "${terraform.workspace}-eventservice.aws.netpy.de"
  ev_table_name = local.prod_ev_table_name
  aws_db_user_access_key = var.aws_db_user_eventservice_access_key
  aws_db_user_secret_key = var.aws_db_user_eventservice_secret_key
}
module "prod-adminservice" {
  source = "./../service_modules/tf_adminservice/prod/"
  release_name_and_namespace_k8s_adminservice = terraform.workspace
  allowed_hosts_adminservice = "${terraform.workspace}-adminservice.aws.netpy.de"
  adminservicetable_endpoint = "${module.prod-admin-table.rds_address}"
  admindb_name = local.prod_admindb_name
  admindb_password = var.admindb_password
  admindb_username = var.admindb_username
  aws_db_user_access_key = var.aws_db_user_adminservice_access_key
  aws_db_user_secret_key = var.aws_db_user_adminservice_secret_key
  aws_tf_user_access_key = var.access_key
  aws_tf_user_secret_key = var.secret_key
  aws_db_user_eventservice_access_key = var.aws_db_user_eventservice_access_key
  aws_db_user_eventservice_secret_key = var.aws_db_user_eventservice_secret_key
  aws_db_user_scraper_generic_access_key = var.aws_db_user_scraper_generic_access_key
  aws_db_user_scraper_generic_secret_key = var.aws_db_user_scraper_generic_secret_key
  gh_token_ui_repos = var.gh_token
  ten_table_name = local.prod_tenant_table_name
  depends_on = [
    module.prod-admin-table
  ]
}
module "prod-tenants-database"{
  source = "./../service_modules/tf_tenanttableservice/prod"
  dbname = local.prod_tenant_table_name
  tags_tenants-database = {
      "Environment" = "Prod"
    }
}

module "prod-event-table" {
  source = "./../service_modules/tf_eventtableservice/prod"
  dbname = local.prod_ev_table_name
  tags_eventtable-database = {
      "Environment" = "Prod"
    }
}

module "prod-admin-table" {
  source = "./../service_modules/tf_admintableservice/prod"
  admindb_name = local.prod_admindb_name
  db_username = var.admindb_username
  db_password = var.admindb_password
}

module "prod-scraper-selenium-service" {
  source = "./../service_modules/tf_scraper_selenium_service/prod/"
  release_name_namespace_k8s_scraper_selenium_service = terraform.workspace
}

module "prod-scraper-generic-service" {
  source = "./../service_modules/tf_scraper_generic_service/prod/"
  aws_db_user_access_key = var.aws_db_user_scraper_generic_access_key
  aws_db_user_secret_key = var.aws_db_user_scraper_generic_secret_key
  release_name_namespace_k8s_scraper_generic_service = terraform.workspace
  scraper_ev_table_name = local.prod_ev_table_name
  scraper_ten_table_name = local.prod_tenant_table_name
  scraper_cronjob_schedule = "0 3 * * *"
  scraper_cronjob_seleniumDNSname = "${terraform.workspace}-scraper-selenium-service.${terraform.workspace}.svc.cluster.local"
}