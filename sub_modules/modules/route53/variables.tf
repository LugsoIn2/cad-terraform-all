variable "subdomainName" {
  description = "The Subdomain Name for the record"
  default = "example"
  type    = string
}

variable "record_type" {
  description = "Record Type"
  default = "A"
  type    = string
}


variable "target_dns" {
  type        = string
  description = "DNS name of target resource"
}

variable "target_zone_id" {
  type        = string
  description = "ID of target resource"
}

variable "evaluate_target_health" {
  type        = bool
  default     = true
  description = "DNS healthy check from Route53"
}