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
