resource "aws_instance" "PACUJPEU1_jenkins" {
  ami                         = var.ubuntu
  instance_type               = var.instance_type
  subnet_id                   = var.PACUJPEU1-prvt
  vpc_security_group_ids      = [var.jenkins_SG]
  key_name                    = var.keypair_name

  user_data = file("../module/jenkins/jenkins.sh")
  
  tags = {
    Name = var.jenkins-name
  }
}