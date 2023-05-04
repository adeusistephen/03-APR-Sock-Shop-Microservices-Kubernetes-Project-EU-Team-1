# Import Route53 Hosted Zone from my aws account
data "aws_route53_zone" "pacujeu1_zone" {
  name         = var.domain_name
  private_zone = false
}

# Create prod record from Route 53 zone
resource "aws_route53_record" "prod" {
  zone_id = data.aws_route53_zone.pacujeu1_zone.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = var.dns_name
    zone_id                = var.zone_id
    evaluate_target_health = false
  }
}