output "ASG" {
  value = aws_autoscaling_group.asg-prod.id
}
output "lc-name" {
  value = aws_launch_configuration.lc-prod.name
}
