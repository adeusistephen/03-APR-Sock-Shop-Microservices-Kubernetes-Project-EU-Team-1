variable "subnet_id1" {}
variable "subnet_id2" {}
variable "elb_sg" {}
variable "elb_instance" {}
variable "elb_name" {
    default = "jenkins-elb"
}
variable "jenkins_elb" {
    default = "jenkins-elb"
}
