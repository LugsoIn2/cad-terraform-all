variable "access_key" {
    sensitive   = true
}

variable "secret_key" {
    sensitive   = true
}

variable "gh_token" {
    sensitive   = true
}

variable "admindb_username" {
    sensitive   = true
}

variable "admindb_password" {
    sensitive   = true
}

variable "aws_db_user_eventservice_access_key" {
    sensitive   = true
}

variable "aws_db_user_eventservice_secret_key" {
    sensitive   = true
}
variable "aws_db_user_adminservice_access_key" {
    sensitive   = true
}

variable "aws_db_user_adminservice_secret_key" {
    sensitive   = true
}
variable "aws_db_user_scraper_generic_access_key" {
    sensitive   = true
}

variable "aws_db_user_scraper_generic_secret_key" {
    sensitive   = true
}