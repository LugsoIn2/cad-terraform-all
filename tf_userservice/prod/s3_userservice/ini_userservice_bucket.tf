terraform {
  backend "s3" {
     bucket         = "cad-terraform-state-service"
     key            = "terraform.tfstate"
     region         = "eu-central-1"
     dynamodb_table = "terraform_state"
   }
}

locals {
 concat_bucket_name = var.bucket_name != "" ? "${terraform.workspace}-${var.bucket_name}" : "${terraform.workspace}"
 #concat_bucket_name = "${terraform.workspace}-${var.bucket_name}"
}

module "userservice_bucket" {
    source = "./../../modules/s3"
    bucket_name = local.concat_bucket_name
    s3_tags = var.tags
    dist_directory = var.dist_directory
    dist_assets_directory = var.dist_assets_directory
}

module "a_record_userservice" {
    source = "./../../modules/route53"
    subdomainName = local.concat_bucket_name
    record_type = "A"
    target_dns = module.userservice_bucket.userservice_website_endpoint
    target_zone_id = module.userservice_bucket.userservice_hosted_zone_id
    evaluate_target_health = true
    depends_on = [module.userservice_bucket]
}

