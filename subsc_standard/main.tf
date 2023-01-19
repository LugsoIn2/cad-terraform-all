module "prod-event-table" {
  source = "./../service_modules/tf_eventtableservice/prod"
  dbname = "${terraform.workspace}_event_table"
  tags_eventtable-database = {
      "Environment" = "Subscription_Standard"
      "Customer" = "${terraform.workspace}"
    }
}