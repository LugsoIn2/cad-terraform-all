variable "allowed_hosts_adminservice" {
    description = "Allowed Hosts from Django adminservice"
    type = string
    default = "localhost,127.0.0.1"
}

variable "release_name_and_namespace_k8s_adminservice" {
    description = "k8s namespace and helm release name adminservice (kd-nr for us)"
    type = string
}

# variable "adminservicetable_endpoint" {
#     description = "the admin table endpoint address"
#     type = string
# }