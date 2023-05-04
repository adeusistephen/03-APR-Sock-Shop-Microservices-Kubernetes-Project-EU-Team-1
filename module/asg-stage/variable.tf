variable "asg-name" {
    default = "asg-stage"
}

variable "subnet1" {}
variable "subnet2" {}
variable "tg-arn" {}

variable "asg-policy" {
    default = "stg-asg_policy"
}
variable "lc-name" {
    default = "stg-lc_config"
}
variable "instance_type" {
    default = "t3.medium"
}

variable "keypair_name" {}
variable "lc-sg" {}
variable "ami-name" {
    default = "stg-lc_ami"
}
variable "source-instance_id" {}
