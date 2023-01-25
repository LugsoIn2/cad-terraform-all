variable "dbname" {
    description = "Name of the tenants DB"
    type = string
}
variable "tags_tenants-database" {
  description = "Key-Value maps for Environment"
    type = map(string)
    default = {}
}