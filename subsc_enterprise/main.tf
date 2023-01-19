locals {
 prod_ev_table_name = "${terraform.workspace}_event_table"
}

module "prod-userservice" {
  source = "./../service_modules/tf_userservice/prod/"
  bucket_name_userservice = "userservice"
  tags_userservice = {
      "Environment" = "Subscription_Enterprise"
      "Customer" = "${terraform.workspace}"
    }
  dist_assets_directory_userservice = "../local_helper/tmp_${terraform.workspace}_userservice/dist/assets"
  dist_directory_userservice = "../local_helper/tmp_${terraform.workspace}_userservice/dist"
  backend_servicename_userservice = "eventservice"
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
module "prod-event-table" {
  source = "./../service_modules/tf_eventtableservice/prod"
  dbname = local.prod_ev_table_name
  tags_eventtable-database = {
      "Environment" = "Subscription_Enterprise"
      "Customer" = "${terraform.workspace}"
    }
}