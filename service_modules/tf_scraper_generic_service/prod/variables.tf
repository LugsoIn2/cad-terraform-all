variable "release_name_namespace_k8s_scraper_generic_service" {
    description = "k8s namespace and helm release name scraper_generic_service (kd-nr for us)"
    type = string
}
variable "scraper_cities" {
    description = "tenant eg. citie name for the scraper - default empty"
    type = string
}
variable "scraper_ev_table_name" {
    description = "Name of the event-table for the scraper"
    type = string
}
variable "scraper_ten_table_name" {
    description = "Name of the tenant table for the scraper"
    type = string
}
variable "scraper_cronjob_schedule" {
    description = "the cronjob schedule for the scraper - default '0 3 * * *'"
    type = string
    #default = "0 3 * * *"
}
variable "scraper_cronjob_seleniumDNSname" {
    description = "the cronjob seleniumDNSname for the scraper"
    type = string
}
variable "scraper_cronjob_seleniumPort" {
    description = "the cronjob seleniumDNSname for the scraper - default 4444"
    type = string
    default = 4444
}
variable "scraper_scraper_name" {
  description = "the scrapername 'GOOGLE' / 'KULA' / 'BFK' (type of scraper)"
  type = string
  default = "GOOGLE"
}

