module "prod-userservice" {
  source = "./../service_modules/tf_userservice/prod/"
  bucket_name_userservice = "userservice"
  tags_userservice = {
      "Environment" = "Prod"
    }
  dist_assets_directory_userservice = "../local_helper/userservice/dist/assets"
  dist_directory_userservice = "../local_helper/userservice/dist"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "prod-adm-ui-service" {
  source = "./../service_modules/tf_adm_ui_service/prod/"
  dist_assets_directory_adm_ui_service = "../local_helper/admin_ui_service/dist/assets"
  dist_directory_adm_ui_service = "../local_helper/admin_ui_service/dist"
  bucket_name_adm_ui_service = "adm-ui-service"
  tags_adm_ui_service = {
    "Environment" = "Prod"
  }
  access_key = var.access_key
  secret_key = var.secret_key
}

