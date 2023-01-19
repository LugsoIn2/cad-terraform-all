module "prod-dynamodb-eventservice"{
  source = "./../service_modules/tf_eventtableservice/prod"
  dbname = "${terraform.workspace}_event_table"
  tags_eventtable-database = {
      "Environment" = "Prod"
    }
}