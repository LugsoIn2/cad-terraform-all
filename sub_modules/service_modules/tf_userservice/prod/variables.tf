variable "bucket_name_userservice" {
  description = "Name for S3 bucket"
  type = string
  #default = "userservice"
}

variable "tags_userservice" {
    description = "Key-Value maps for tagging"
    type = map(string)
    default = {}
}
variable "dist_directory_userservice" {
  description = "path to userservice dist dir"
  type = string
  #default = "../../dist"
}

variable "dist_assets_directory_userservice" {
  description = "Path to userservice dist assets dir"
  type = string
  #default = "../../dist/assets"
}

variable "https_enabled_userservice" {
  description = "backend url https enabled. enabled = 1, disabled = 0 (default: 0)"
  type = number
  default = 0
}

variable "backend_servicename_userservice" {
  description = "backend servicename for the userservice"
  type = string
}