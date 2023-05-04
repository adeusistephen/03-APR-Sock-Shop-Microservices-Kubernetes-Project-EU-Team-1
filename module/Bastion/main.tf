resource "aws_instance" "PACUJPEU1_Bastion" {
  ami                         = var.ubuntu
  instance_type               = var.instance_type
  subnet_id                   = var.PACUJPEU1-PubSub01_id
  vpc_security_group_ids      = [var.Bast_Ans_SG]
  key_name                    = var.keypair_name
  associate_public_ip_address = true
  user_data = templatefile("../module/Bastion/bastion.sh", {
    keypair=var.private_key
})
  
  tags = {
    Name = var.bastion-name
  }
}