variable "aws_db_user_access_key" {
    sensitive   = true
}
variable "aws_db_user_secret_key" {
    sensitive   = true
}
variable "aws_tf_user_access_key" {
    sensitive   = true
}
variable "aws_tf_user_secret_key" {
    sensitive   = true
}
variable "aws_db_user_eventservice_access_key" {
    sensitive   = true
}
variable "aws_db_user_eventservice_secret_key" {
    sensitive   = true
}
variable "gh_token_ui_repos" {
    sensitive   = true
}
variable "admindb_username" {
    description = "the username of the admin table"
    type = string
    sensitive = true
}
variable "admindb_password" {
    description = "the password of the admin table"
    type = string
    sensitive = true
}
variable "aws_db_user_scraper_generic_access_key" {
    sensitive   = true
}
variable "aws_db_user_scraper_generic_secret_key" {
    sensitive   = true
}