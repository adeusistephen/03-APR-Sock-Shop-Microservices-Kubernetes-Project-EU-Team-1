output "prometheus-lb" {
    value = aws_elb.prometheus-lb.dns_name
}
