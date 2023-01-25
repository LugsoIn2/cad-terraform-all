locals {
 #concat_bucket_name = var.bucket_name_adm_ui_service != "" ? "${terraform.workspace}-${var.bucket_name_adm_ui_service}" : "${terraform.workspace}"
 concat_bucket_name = "${terraform.workspace}-${var.bucket_name_adm_ui_service}"
}
data "external" "build_admin_ui" {
	program = ["bash", "-c", <<EOT
./load_and_build_admin_ui.sh ${var.gh_token} ${terraform.workspace} -${var.backend_servicename_adm_ui_service} ${var.https_enabled_adm_ui_service} >&2 && echo "{\"dest\": \"./tmp_${terraform.workspace}_admin_ui\"}"
EOT
	]
	working_dir = "${path.module}/../../../../local_helper/"
}
module "adm_ui_service_bucket" {
    source = "./../../../modules/s3"
    bucket_name = local.concat_bucket_name
    s3_tags = var.tags_adm_ui_service
    dist_directory = var.dist_directory_adm_ui_service
    dist_assets_directory = var.dist_assets_directory_adm_ui_service
    depends_on = [
      data.external.build_admin_ui
    ]
}

module "a_record_adm_ui_service" {
    source = "./../../../modules/route53"
    subdomainName = local.concat_bucket_name
    record_type = "A"
    target_dns = module.adm_ui_service_bucket.static_web_website_endpoint
    target_zone_id = module.adm_ui_service_bucket.static_web_hosted_zone_id
    evaluate_target_health = true
    depends_on = [module.adm_ui_service_bucket]
}

data "external" "clean_tmp_files_admin_ui" {
	program = ["bash", "-c", <<EOT
./clean_tmp_files_admin_ui.sh ${terraform.workspace} >&2 && echo "{\"clean\": \"true\"}"
EOT
	]
	working_dir = "${path.module}/../../../../local_helper/"
    depends_on = [module.adm_ui_service_bucket]
}