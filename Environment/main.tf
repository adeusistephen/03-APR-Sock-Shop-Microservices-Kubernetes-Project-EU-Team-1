locals {
  project_name = "PACUJPEU1"
}
module "vpc" {
  source = "../module/vpc"
}

module "keypair" {
    source = "../module/keypair"
}

module "security-group" {
  source = "../module/security-group"
  vpc_id       = module.vpc.vpc_id
}

module "bastion" {
  source = "../module/Bastion"
  ubuntu = var.ami
  instance_type = var.instance_type
  PACUJPEU1-PubSub01_id = module.vpc.PubSub01
  Bast_Ans_SG = module.security-group.Bast_Ans_SG
  keypair_name = module.keypair.keypair_name  
}

module "Master-Node" {
  source = "../module/master-node"
  ubuntu = var.ami
  instance_type = var.instance_type
  PACUJPEU1-prvt = module.vpc.PrvtSub01
  PACUJPEU1_mas_work_sg = module.security-group.mas_work_sg
  keypair_name = module.keypair.keypair_name  
}

module "Worker-Node" {
  source = "../module/worker-node"
  ubuntu = var.ami
  instance_type = var.instance_type
  PACUJPEU1-prvt = module.vpc.PrvtSub01
  PACUJPEU1_mas_work_sg = module.security-group.mas_work_sg
  keypair_name = module.keypair.keypair_name  
}

module "jenkins" {
  source = "../module/jenkins"
  ubuntu = var.ami
  instance_type = var.instance_type
  PACUJPEU1-prvt = module.vpc.PrvtSub01
  jenkins_SG = module.security-group.jenkins_SG
  keypair_name = module.keypair.keypair_name  
}

module "HAproxy-Prod" {
  source = "../module/HA-Proxy1"
  ubuntu = var.ami
  instance_type = var.instance_type
  PACUJPEU1-prvt = module.vpc.PrvtSub01
  mas_work_sg = module.security-group.mas_work_sg
  keypair_name = module.keypair.keypair_name 
  master1 = module.Master-Node.Master_Node_IP[0]
  master2 = module.Master-Node.Master_Node_IP[1]
  master3 = module.Master-Node.Master_Node_IP[2]
}

module "HAProxy_backup" {
  source = "../module/HA-Proxy_backup"
  ubuntu = var.ami
  instance_type = var.instance_type
  PACUJPEU1-prvt = module.vpc.PrvtSub02
  mas_work_sg = module.security-group.mas_work_sg
  keypair_name = module.keypair.keypair_name 
  master1 = module.Master-Node.Master_Node_IP[0]
  master2 = module.Master-Node.Master_Node_IP[1]
  master3 = module.Master-Node.Master_Node_IP[2] 
}

module "HAproxy-stage" {
  source = "../module/stage-HAProxy"
  ubuntu = var.ami
  instance_type = var.instance_type
  PACUJPEU1-prvt = module.vpc.PrvtSub01
  mas_work_sg = module.security-group.mas_work_sg
  keypair_name = module.keypair.keypair_name 
  stage_master1 = module.Master-Node.Master_Node_IP[3]
  stage_master2 = module.Master-Node.Master_Node_IP[4]
  stage_master3 = module.Master-Node.Master_Node_IP[5]
}

module "stage-HAProxy_backup" {
  source = "../module/stage-HAProxy_backup"
  ubuntu = var.ami
  instance_type = var.instance_type
  PACUJPEU1-prvt = module.vpc.PrvtSub02
  mas_work_sg = module.security-group.mas_work_sg
  keypair_name = module.keypair.keypair_name 
  stage_master1 = module.Master-Node.Master_Node_IP[3]
  stage_master2 = module.Master-Node.Master_Node_IP[4]
  stage_master3 = module.Master-Node.Master_Node_IP[5]
}

module "continous-testing" {
  source = "../module/continous-testing"
  red-ami = var.red-ami
  instance_type = var.instance_type
  PACUJPEU1-prvt = module.vpc.PrvtSub01
  cont-SG =  module.security-group.mas_work_sg
  keypair_name = module.keypair.keypair_name

}
module "iam" {
  source = "../module/iam"

}

module "ansible" {
  source = "../module/ansible"
  ubuntu = var.ami
  iam_instance_profile = module.iam.iam-profile-name
  PACUJPEU1-prvt = module.vpc.PrvtSub01
  instance_type = var.instance_type
  ansible-SG = module.security-group.mas_work_sg
  keypair_name = module.keypair.keypair_name
  HAproxy_IP = module.HAproxy-Prod.prod_HAProxy_IP
  HAproxy1_IP = module.HAproxy-Prod.prod_HAProxy_IP
  HAproxy2_IP = module.HAProxy_backup.prod_HAProxy_backup_IP
  stage_HAproxy_IP = module.HAproxy-stage.stage_HAproxy_IP
  stage_HAproxy_IP2 = module.stage-HAProxy_backup.stage_HAproxy_IP
  master1_IP = module.Master-Node.Master_Node_IP[0]
  master2_IP = module.Master-Node.Master_Node_IP[1]
  master3_IP = module.Master-Node.Master_Node_IP[2]
  worker_IP = module.Worker-Node.Worker-Node_prvt[0]
  stage_master1_IP = module.Master-Node.Master_Node_IP[3]
  stage_master2_IP = module.Master-Node.Master_Node_IP[4]
  stage_master3_IP = module.Master-Node.Master_Node_IP[5]
  stage_worker_IP = module.Worker-Node.Worker-Node_prvt[1]
}

resource "null_resource" "ansible_configure" {
  connection {
    type                = "ssh"
    host                = module.ansible.ansible_IP
    user                = "ubuntu"
    private_key         = file("~/keypair/PACUJPEU1-key")
    bastion_host        = module.bastion.bastion_public_ip
    bastion_user        = "ubuntu"
    bastion_private_key = file("~/keypair/PACUJPEU1-key")
  }
  provisioner "file" {
    source      = "../Environment/playbook" 
    destination = "/home/ubuntu/playbooks"
  }
}

module "jenkin-elb" {
  source = "../module/jenkins-elb"
  subnet_id1 = module.vpc.PubSub01
  subnet_id2 = module.vpc.PubSub02
  elb_sg = module.security-group.mas_work_sg
  elb_instance = module.jenkins.Jenkins_ID
}

# Prometheus Elastic Load Balancer
module "prometheus_elb" {
  source = "../module/prometheus_elb"
  subnet_id1= module.vpc.PubSub01
  subnet_id2= module.vpc.PubSub02
  securitygroup_id= module.security-group.mas_work_sg
  instance_id = module.Worker-Node.Worker-Node_InstanceID[0]
}

# Grafana Elastic Load Balancer
module "grafana_elb" {
  source = "../module/grafana_elb"
  subnet_id1= module.vpc.PubSub01
  subnet_id2= module.vpc.PubSub02
  securitygroup_id= module.security-group.mas_work_sg
  instance_id = module.Worker-Node.Worker-Node_InstanceID[0]
}

module "prod-lb" {
  source = "../module/prod-lb"
  lb-subnet1 = module.vpc.PubSub01
  lb-subnet2 = module.vpc.PubSub02
  vpc_id = module.vpc.vpc_id
  instance_id = module.Worker-Node.Worker-Node_InstanceID[0]
  sg_lb = module.security-group.mas_work_sg
}

module "stg-lb" {
  source = "../module/stg-lb"
  lb-subnet1 = module.vpc.PubSub01
  lb-subnet2 = module.vpc.PubSub02
  vpc_id = module.vpc.vpc_id
  instance_id = module.Worker-Node.Worker-Node_InstanceID[1]
  sg_lb = module.security-group.mas_work_sg
}

module "stage-asg" {
  source              = "../module/asg-stage"
  subnet1 = module.vpc.PubSub01
  subnet2 = module.vpc.PubSub02
  tg-arn = module.stg-lb.lb-tg
  keypair_name = module.keypair.keypair_name
  lc-sg = module.security-group.mas_work_sg
  source-instance_id =  module.Worker-Node.Worker-Node_InstanceID[1]
}

module "prod-asg" {
  source              = "../module/asg-prod"
  subnet1 = module.vpc.PubSub01
  subnet2 = module.vpc.PubSub02
  tg-arn = module.prod-lb.lb-tg
  keypair_name = module.keypair.keypair_name
  lc-sg = module.security-group.mas_work_sg
  source-instance_id =  module.Worker-Node.Worker-Node_InstanceID[0]
}


module "aws-acm" {
  source = "../module/aws-acm"
  domain_name = var.domain_name
  lb_arn = module.prod-lb.lb-arn
  lb_target_arn = module.prod-lb.lb-tg
}

module "route53" {
  source = "../module/route53"
  domain_name = var.domain_name
  dns_name = module.prod-lb.lb-dns
  zone_id = module.prod-lb.lb-zone_id
}
