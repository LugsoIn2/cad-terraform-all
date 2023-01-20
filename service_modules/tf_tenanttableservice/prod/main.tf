resource "aws_dynamodb_table" "tenants_tables" {
  name               = var.dbname
  billing_mode       = "PROVISIONED"
  read_capacity      = "30"
  write_capacity     = "30"
  hash_key           = "city"

  attribute {
    name = "user_Id"
    type = "S"
  }

  attribute {
    name = "subscription_type"
    type = "N"
  }

  attribute {
    name = "city"
    type = "S"
  }

  attribute {
    name = "customer_nr"
    type = "S"
  }

  # ttl {
  #   enabled        = false
  #   attribute_name = "TimeToExist"
  # }

  global_secondary_index {
    name               = "subscription_type-index"
    hash_key           = "subscription_type"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "ALL"
  }
  global_secondary_index {
    name               = "user_id-index"
    hash_key           = "user_Id"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "ALL"
  }
  global_secondary_index {
    name               = "customer_nr-index"
    hash_key           = "customer_nr"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "ALL"
  }

}
