locals {
 #concat_bucket_name = var.bucket_name_userservice != "" ? "${terraform.workspace}-${var.bucket_name_userservice}" : "${terraform.workspace}"
 concat_bucket_name = "${terraform.workspace}-${var.bucket_name_userservice}"
}

data "external" "build_userservice" {
	program = ["bash", "-c", <<EOT
./load_and_build_userservice.sh ${var.gh_token} ${terraform.workspace} -${var.backend_servicename_userservice} ${var.https_enabled_userservice} >&2 && echo "{\"dest\": \"./tmp_${terraform.workspace}_userservice\"}"
EOT
	]
	working_dir = "${path.module}/../../../local_helper/"
}
module "userservice_bucket" {
    source = "./../../../modules/s3"
    bucket_name = local.concat_bucket_name
    s3_tags = var.tags_userservice
    dist_directory = var.dist_directory_userservice
    dist_assets_directory = var.dist_assets_directory_userservice
    depends_on = [
      data.external.build_userservice
    ]
}

module "a_record_userservice" {
    source = "./../../../modules/route53"
    subdomainName = local.concat_bucket_name
    record_type = "A"
    target_dns = module.userservice_bucket.static_web_website_endpoint
    target_zone_id = module.userservice_bucket.static_web_hosted_zone_id
    evaluate_target_health = true
    depends_on = [module.userservice_bucket]
}

data "external" "clean_tmp_files_userservice" {
	program = ["bash", "-c", <<EOT
./clean_tmp_files_userservice.sh ${terraform.workspace} >&2 && echo "{\"clean\": \"true\"}"
EOT
	]
	working_dir = "${path.module}/../../../local_helper/"
    depends_on = [module.userservice_bucket]
}
