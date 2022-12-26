module "prod-userservice" {
  source = "./../service_modules/tf_userservice/prod/"
  bucket_name_userservice = "userservice"
  dist_directory_userservice = var.dist_directory_userservice
  dist_assets_directory_userservice = var.dist_assets_directory_userservice
  tags_userservice = var.tags_userservice
  access_key = var.access_key
  secret_key = var.secret_key
}

module "prod-adm-ui-service" {
  source = "./../service_modules/tf_adm_ui_service/prod/"
  bucket_name_adm_ui_service = "adm-ui-service"
  dist_directory_adm_ui_service = var.dist_directory_adm_ui_service
  dist_assets_directory_adm_ui_service = var.dist_assets_directory_adm_ui_service
  tags_adm_ui_service = var.tags_adm_ui_service
  access_key = var.access_key
  secret_key = var.secret_key
}

