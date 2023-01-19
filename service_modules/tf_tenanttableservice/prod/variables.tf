variable "dbname" {
    description = "Name of the tenants DB"
    type = string
    default = "tenants" 
}
variable "tags_tenatns-database" {
  description = "Key-Value maps for Environment"
    type = map(string)
    default = {}
}