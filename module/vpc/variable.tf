variable "project_name" {
    default = "PACUJPEU1"
}
variable "vpc-cidr" {
    default = "10.0.0.0/16"
}
variable "PubSub01_cidr" {
    default = "10.0.1.0/24"
}
variable "PubSub02_cidr" {
    default = "10.0.2.0/24"
}
variable "az1" {
    default = "eu-west-3a"
}
variable "az2" {
    default = "eu-west-3b"
}

variable "PrvtSub01_cidr" {
    default = "10.0.3.0/24"
}
variable "PrvtSub02_cidr" {
    default = "10.0.4.0/24"
}

variable "all-cidr" {
    default = "0.0.0.0/0"
}
