module "prod-userservice" {
  source = "./../service_modules/tf_userservice/prod/"
  bucket_name_userservice = "userservice"
  dist_directory_userservice = var.dist_directory_userservice
  dist_assets_directory_userservice = var.dist_assets_directory_userservice
  tags_userservice = var.tags_userservice
  access_key = var.access_key
  secret_key = var.secret_key
}

