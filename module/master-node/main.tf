#Create master node Host
resource "aws_instance" "PACUJPEU1_master-node" {
  ami                         = var.ubuntu
  instance_type               = var.instance_type
  subnet_id                   = var.PACUJPEU1-prvt
  vpc_security_group_ids      = [var.PACUJPEU1_mas_work_sg]
  key_name                    = var.keypair_name
  count                       = var.instance_count

  tags = {
    Name = "${var.instance_name}${count.index}"
  }
}