output "jenkins_lb_dns" {
  value = aws_elb.jenkins_elb.dns_name
}