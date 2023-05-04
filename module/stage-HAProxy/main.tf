resource "aws_instance" "PACUJPEU1_HAProxy2" {
  ami                         = var.ubuntu
  instance_type               = var.instance_type
  subnet_id                   = var.PACUJPEU1-prvt
  vpc_security_group_ids      = [var.mas_work_sg]
  key_name                    = var.keypair_name

  user_data = templatefile("../module/stage-HAProxy/HA-Proxy.sh", {
    stage_master1=var.stage_master1,
    stage_master2=var.stage_master2,
    stage_master3=var.stage_master3
  })
  
  tags = {
    Name = var.HAProxy2
  }
}