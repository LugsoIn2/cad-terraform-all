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
  access_key = var.access_key
  secret_key = var.secret_key
}