output "ns_records" {
  value = data.aws_route53_zone.pacujeu1_zone.name_servers
}
output "cert-arn" {
   value = aws_acm_certificate.pacujeu1-certificate.arn
}