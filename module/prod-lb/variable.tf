variable "lb_name" {
    default = "prod-LoadBalancer"
}

variable "lb-subnet1" {}
variable "lb-subnet2" {}
variable "prod_tg" {
    default = "prod-TargetGrp"
}

variable "lb_target-type" {
    default = "instance"
}

variable "vpc_id" {}
variable "instance_id" {}
variable "sg_lb" {}