resource "aws_elb" "jenkins_elb" {
  name            = var.elb_name
  subnets         = [var.subnet_id1, var.subnet_id2]
  security_groups = [var.elb_sg]
  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 30
  }
  instances                   = [var.elb_instance]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = var.jenkins_elb
  }
}