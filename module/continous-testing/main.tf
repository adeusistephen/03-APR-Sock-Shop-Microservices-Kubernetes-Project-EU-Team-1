resource "aws_instance" "PACUJPEU1_continous-testing" {
  ami                         = var.red-ami
  instance_type               = var.instance_type
  subnet_id                   = var.PACUJPEU1-prvt
  vpc_security_group_ids      = [var.cont-SG]
  key_name                    = var.keypair_name

  user_data = file("../module/continous-testing/continous.sh")
  
  tags = {
    Name = var.continous-name
  }
}