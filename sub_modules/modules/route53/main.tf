resource "aws_route53_record" "subdom_aws_netpy_de" {
  #zone_id = aws_route53_zone.aws.netpy.de.Z0220617X0Q91R5ISP0T
  zone_id = "Z0220617X0Q91R5ISP0T"
  name    = "${var.subdomainName}.aws.netpy.de"
  type    = var.record_type
  alias {
    #name                   = aws_s3_bucket.example.website_endpoint
    #zone_id                = aws_s3_bucket.example.hosted_zone_id
    #evaluate_target_health = true
    name                   = var.target_dns
    zone_id                = var.target_zone_id
    evaluate_target_health = var.evaluate_target_health
    }
}