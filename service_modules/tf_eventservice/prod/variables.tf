variable "allowed_hosts_eventservice" {
    description = "Allowed Hosts from Django eventservice"
    type = string
    default = "localhost,127.0.0.1"
}

variable "release_name_and_namespace_k8s_eventservice" {
    description = "k8s namespace and helm release name eventservice (kd-nr for us)"
    type = string
}
