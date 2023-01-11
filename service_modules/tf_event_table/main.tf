resource "aws_dynamodb_table" "event_tableblatest" {
  name               = var.dynamo_table_name
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

  ttl {
    enabled        = false
    attribute_name = "TimeToExist"
  }

global_secondary_index {
    name               = "eventDate-index"
    hash_key           = "eventDate"
    #range_key          = "date"
    write_capacity     = 30
    read_capacity      = 30
    projection_type    = "INCLUDE"
    #non_key_attributes = ["dateString"]
  }


  tags = var.dynamo_table_tags

}
