variable "dynamo_table_name" {
  description = "the name of the dynamodb table"
  type = string
}

# variable "dynamo_table_hash_key" {
#     description = "the hash key of the table"
#     type = string
# }

# variable "dynamo_table_range_key" {
#     description = "the range key of the table"
#     type = string
# }

variable "dynamo_table_tags" {
    description = "tags for the dynamo table"
    type = map(string)
    default = {}
}