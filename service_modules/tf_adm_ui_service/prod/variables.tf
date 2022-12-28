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

variable "https_enabled_adm_ui_service" {
  description = "backend url https enabled. enabled = 1, disabled = 0 (default: 0)"
  type = number
  default = 0
}

variable "backend_servicename_adm_ui_service" {
  description = "backend servicename for the admin ui service"
  type = string
}