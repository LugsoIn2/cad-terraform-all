locals {
  complete_bucket_name = "${var.bucket_name}.aws.netpy.de"
}

module "template_files" {
  source = "hashicorp/dir/template"
  version = "1.0.2"
  base_dir = var.dist_directory
}

module "template_files_assets" {
  source = "hashicorp/dir/template"
  version = "1.0.2"
  base_dir = var.dist_assets_directory
}


resource "aws_s3_bucket" "userservice_bucket" {
  bucket = local.complete_bucket_name
  tags = var.s3_tags
}

resource "aws_s3_bucket_website_configuration" "userservice_bucket-config" {
  bucket = aws_s3_bucket.userservice_bucket.bucket

  index_document {
    suffix = "index.html"
  }

}

resource "aws_s3_bucket_policy" "userservice-bucket-policy" {
  bucket = aws_s3_bucket.userservice_bucket.bucket
  policy = data.aws_iam_policy_document.allow_access_from_all.json
}


resource "aws_s3_bucket_object" "root" {
  bucket = "${aws_s3_bucket.userservice_bucket.id}"

  for_each = module.template_files.files
  key    = each.key
  content_type = each.value.content_type
  source  = each.value.source_path
  content = each.value.content
  etag = each.value.digests.md5
}

resource "aws_s3_bucket_object" "assets" {
  bucket = "${aws_s3_bucket.userservice_bucket.id}"

  for_each = module.template_files_assets.files
  key    = each.key
  content_type = each.value.content_type
  source  = each.value.source_path
  content = each.value.content
  etag = each.value.digests.md5
}

data "aws_iam_policy_document" "allow_access_from_all" {
  statement {
    sid = "PublicReadAccess"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    effect = "Allow"
    #resources = [
    #  "arn:aws:s3:::cad-team3-frontend-tf/*",
    #]
    resources = [
      "arn:aws:s3:::${local.complete_bucket_name}/*",
    ]
  }
}


output "userservice_website_endpoint" {
  #value = aws_s3_bucket.userservice_bucket.website_endpoint
  value = aws_s3_bucket_website_configuration.userservice_bucket-config.website_domain
}

output "userservice_hosted_zone_id" {
  value = aws_s3_bucket.userservice_bucket.hosted_zone_id
}