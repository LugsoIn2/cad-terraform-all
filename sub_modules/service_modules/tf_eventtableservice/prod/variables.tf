variable "dbname"{
    type = string
    description = "name for the DB in the free version"
}

variable "tags_eventtable-database" {
    description = "Key-Value maps for Environment"
    type = map(string)
    default = {}
}

