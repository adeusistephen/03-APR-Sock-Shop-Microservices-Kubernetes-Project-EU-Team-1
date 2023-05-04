output "ASG" {
  value = aws_autoscaling_group.asg-stage.id
}
output "lc-name" {
  value = aws_launch_configuration.lc-stage.name
}
