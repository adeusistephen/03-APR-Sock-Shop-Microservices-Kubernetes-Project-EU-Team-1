# Creating EC2 keypair
 resource "aws_key_pair" "PACUJPEU1-keypair" {
   key_name = var.keypair_name
   public_key = file(var.public_key)
 }