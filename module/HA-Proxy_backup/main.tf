resource "aws_instance" "PACUJPEU1_HAProxy_backup" {
  ami                         = var.ubuntu
  instance_type               = var.instance_type
  subnet_id                   = var.PACUJPEU1-prvt
  vpc_security_group_ids      = [var.mas_work_sg]
  key_name                    = var.keypair_name

  user_data = templatefile("../module/HA-Proxy_backup/HA-Proxy.sh", {
    master1=var.master1,
    master2=var.master2,
    master3=var.master3
  })
  
  tags = {
    Name = var.HAProxy_backup
  }
}