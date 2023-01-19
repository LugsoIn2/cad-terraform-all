locals {
 prod_ev_table_name = "${terraform.workspace}_event_table"
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
  access_key = var.access_key
  secret_key = var.secret_key
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
  access_key = var.access_key
  secret_key = var.secret_key
  gh_token = var.gh_token
}

module "prod-eventservice" {
  source = "./../service_modules/tf_eventservice/prod/"
  release_name_and_namespace_k8s_eventservice = terraform.workspace
  allowed_hosts_eventservice = "${terraform.workspace}-eventservice.aws.netpy.de"
  ev_table_name = local.prod_ev_table_name
  access_key = var.access_key
  secret_key = var.secret_key
}
module "prod-adminservice" {
  source = "./../service_modules/tf_adminservice/prod/"
  release_name_and_namespace_k8s_adminservice = terraform.workspace
  allowed_hosts_adminservice = "${terraform.workspace}-adminservice.aws.netpy.de"
  access_key = var.access_key
  secret_key = var.secret_key
}
module "prod-tenants-database"{
  source = "./../service_modules/tf_tenanttableservice/prod"
  dbname = "${terraform.workspace}_tenants"
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