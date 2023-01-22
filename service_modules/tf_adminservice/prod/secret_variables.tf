variable "access_key" {
    sensitive   = true
}

variable "secret_key" {
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