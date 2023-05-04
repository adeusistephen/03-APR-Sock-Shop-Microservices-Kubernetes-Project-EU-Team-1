# Create EC2 Instance for Ansible 
resource "aws_instance" "PACUJPEU1_ansible" {
  ami                    = var.ubuntu
  instance_type          = var.instance_type
  subnet_id              = var.PACUJPEU1-prvt
  iam_instance_profile   = var.iam_instance_profile
  vpc_security_group_ids = [var.ansible-SG]
  key_name               = var.keypair_name

  user_data = templatefile("../module/ansible/ansible.sh", {
    prv_key=var.prv_key,
    HAproxy_IP=var.HAproxy_IP,
    HAproxy1_IP=var.HAproxy1_IP,
    HAproxy_IP2=var.HAproxy2_IP,
    stage_HAproxy_IP=var.stage_HAproxy_IP,
    stage_HAproxy_IP2=var.stage_HAproxy_IP2,
    master1_IP=var.master1_IP,
    master2_IP=var.master2_IP,
    master3_IP=var.master3_IP,
    worker_IP=var.worker_IP,
    stage_master1_IP=var.stage_master1_IP,
    stage_master2_IP=var.stage_master2_IP,
    stage_master3_IP=var.stage_master3_IP,
    stage_worker_IP=var.stage_worker_IP


  })

  tags = {
    Name = var.ansible-name
  }
}