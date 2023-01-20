resource "aws_dynamodb_table" "event_table" {
  name               = var.dbname
  billing_mode       = "PROVISIONED"
  read_capacity      = "30"
  write_capacity     = "30"
  hash_key           = "eventId"
  range_key          = "city"

  attribute {
    name = "eventId"
    type = "S"
  }

  attribute {
    name = "eventDate"
    type = "S"
  }

  attribute {
    name = "city"
    type = "S"
  }
 
  # ttl {
  #   enabled        = false
  #   attribute_name = "TimeToExist"
  # }

  global_secondary_index {
    name               = "eventDate-index"
    hash_key           = "eventDate"
    write_capacity     = 30
    read_capacity      = 30
    projection_type    = "ALL"
  }
}
