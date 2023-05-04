variable "asg-name" {
    default = "asg-prod"
}

variable "subnet1" {}
variable "subnet2" {}
variable "tg-arn" {}

variable "asg-policy" {
    default = "prod-asg_policy"
}
variable "lc-name" {
    default = "prod-lc_config"
}
variable "instance_type" {
    default = "t3.medium"
}

variable "keypair_name" {}
variable "lc-sg" {}
variable "ami-name" {
    default = "prod-lc_ami"
}
variable "source-instance_id" {}

