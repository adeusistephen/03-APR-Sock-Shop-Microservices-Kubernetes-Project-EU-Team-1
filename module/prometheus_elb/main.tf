resource "aws_elb" "prometheus-lb" {
  name            = var.prometheus-lb-name
  subnets         = [var.subnet_id1, var.subnet_id2]
  security_groups = [var.securitygroup_id]

  listener {
    instance_port     = var.lb_instance_port
    instance_protocol = var.instance-lb_protocol
    lb_port           = var.lb_port
    lb_protocol       = var.instance-lb_protocol
  }

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    target              = "TCP:31090"
    interval            = var.interval
  }

  instances                   = [var.instance_id]
  cross_zone_load_balancing   = true
  idle_timeout                = var.idle_timeout
  connection_draining         = true
  connection_draining_timeout = var.connection_draining_timeout

  tags = {
    Name = var.prometheus-lb-name
  }
}