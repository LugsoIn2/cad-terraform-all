variable "bucket_name" {
  description = "Name for S3 bucket"
  type = string
  default = "temp"
}

variable "s3_tags" {
    description = "Key-Value maps for tagging"
    type = map(string)
    default = {}
}

variable "dist_directory" {
  description = "path to dist dir"
  type = string
  default = "../../../dist"
}

variable "dist_assets_directory" {
  description = "path to dist assets dir"
  type = string
  default = "../../../dist/assets"
}