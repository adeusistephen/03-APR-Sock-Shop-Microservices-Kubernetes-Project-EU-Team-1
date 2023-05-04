#Security group for Bastion Host and Ansible
resource "aws_security_group" "PACUJPEU1-Bastion-Ansible-SG" {
  name =  "${var.project_name}-Bast_Ans_SG"
  description ="Allow inbound Traffic"
  vpc_id = var.vpc_id

  ingress {
    description = "ssh access"
    from_port = var.port_ssh
    to_port = var.port_ssh
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks =[var.all-cidr]
  }

  tags = {
    Name = "${var.project_name}-Bast_Ans_SG"
  }
}

#Security group for Jenkins
resource "aws_security_group" "PACUJPEU1-Jenkins-SG" {
  name ="${var.project_name}-jenkins_SG"
  description = "Allow inbound Traffic"
  vpc_id = var.vpc_id

  ingress {
    description = "Http Proxy"
    from_port = var.port_proxy
    to_port = var.port_proxy
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }
  ingress {
    description = "ssh access"
    from_port = var.port_ssh
    to_port = var.port_ssh
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.all-cidr]
  }

  tags = {
    Name = "${var.project_name}-jenkins_SG"
  }
}

#Security group for Masters/worker node
resource "aws_security_group" "PACUJPEU1_mas_work_sg" {
  name ="${var.project_name}-mas_work_sg"
  description = "Allow inbound Traffic"
  vpc_id = var.vpc_id

  ingress {
    description = "Http Proxy"
    from_port = var.port_proxy
    to_port = var.port_proxy
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }
    ingress {
    description = "port_https"
    from_port = var.port_https
    to_port = var.port_https
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }
   ingress {
    description = "Http80"
    from_port = var.port_proxy3
    to_port = var.port_proxy3
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }
  ingress {
    description = "ssh access"
    from_port = var.port_ssh
    to_port = var.port_ssh
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }

  ingress {
    from_port = var.port_proxy2
    to_port = var.port_proxy2
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }

    ingress { 
    from_port = var.port_app
    to_port = var.port_app
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }

    ingress { 
    from_port = var.port_graf
    to_port = var.port_graf
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }

    ingress { 
    from_port = var.port_prom
    to_port = var.port_prom
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }
      ingress { 
    from_port = var.port_etcd
    to_port = var.port_prom
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }

      ingress { 
    from_port = var.port_etcd_client
    to_port = var.port_prom
    protocol = "tcp"
    cidr_blocks =[var.all-cidr]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.all-cidr]
  }

  tags = {
    Name = "${var.project_name}-mas_stage_SG"
  }
}
