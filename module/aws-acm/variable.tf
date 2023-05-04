variable "domain_name" {}
variable "lb_arn" {}

variable "secureport" {
    default = 443
}

variable "protocol" {
    default = "HTTPS"
}

variable "lb_target_arn" {}