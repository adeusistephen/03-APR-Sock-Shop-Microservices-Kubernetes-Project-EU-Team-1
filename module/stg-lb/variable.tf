variable "lb_name" {
    default = "stg-LoadBalancer"
}

variable "lb-subnet1" {}
variable "lb-subnet2" {}
variable "stg_tg" {
    default = "stg-TargetGrp"
}

variable "lb_target-type" {
    default = "instance"
}

variable "vpc_id" {}
variable "instance_id" {}
variable "sg_lb" {}