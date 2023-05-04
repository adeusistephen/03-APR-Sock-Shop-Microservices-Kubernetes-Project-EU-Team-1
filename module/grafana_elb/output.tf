output "grafana-lb" {
    value = aws_elb.grafana-lb.dns_name
}
