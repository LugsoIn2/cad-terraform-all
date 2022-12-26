variable "bucket_name_adm_ui_service" {
  description = "Name for S3 bucket"
  type = string
  #default = "adm_ui_service"
}

variable "tags_adm_ui_service" {
    description = "Key-Value maps for tagging"
    type = map(string)
    default = {}
}
variable "dist_directory_adm_ui_service" {
  description = "path to adm_ui_service dist dir"
  type = string
  #default = "../../dist"
}

variable "dist_assets_directory_adm_ui_service" {
  description = "Path to adm_ui_service dist assets dir"
  type = string
  #default = "../../dist/assets"
}