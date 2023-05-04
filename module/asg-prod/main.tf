#Create AutoScaling Group
resource "aws_autoscaling_group" "asg-prod" {
  name                      = var.asg-name
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 120
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.lc-prod.id
  vpc_zone_identifier       = [var.subnet1,var.subnet2]
  target_group_arns         = [var.tg-arn]
  tag{
    key                 = "Name"
    value               = "prod-worker"
    propagate_at_launch = true
  }
 
}
#Create ASG Policy
resource "aws_autoscaling_policy" "asg-policy" {
  name =  var.asg-policy
  adjustment_type = "ChangeInCapacity"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.asg-prod.id
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60.0
  }
}

#Launch Configuration Template
resource "aws_launch_configuration" "lc-prod" {
  name                        = var.lc-name
  image_id                    = aws_ami_from_instance.prod-worker_ami.id
  instance_type               = var.instance_type
  key_name                    = var.keypair_name
  associate_public_ip_address = true
  security_groups             = [var.lc-sg]
}

#Create AMI from worker
resource "aws_ami_from_instance" "prod-worker_ami" {
  name                    = var.ami-name
  source_instance_id      = var.source-instance_id
}