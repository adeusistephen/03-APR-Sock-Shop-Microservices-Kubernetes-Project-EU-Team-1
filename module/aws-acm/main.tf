# Import Route53 Hosted Zone from my aws account
data "aws_route53_zone" "pacujeu1_zone" {
  name         = var.domain_name
  private_zone = false
}

# Creating Certifcate for entire Domain Name
resource "aws_acm_certificate" "pacujeu1-certificate" {
  domain_name               = var.domain_name
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

# Creating record set in Route53 for Domain Validation
resource "aws_route53_record" "pacujeu1-validation-record" {
  for_each = {
    for dvo in aws_acm_certificate.pacujeu1-certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  ttl             = 60
  zone_id         = data.aws_route53_zone.pacujeu1_zone.zone_id
}

# Creating instruction to validate ACM certificate
resource "aws_acm_certificate_validation" "pacujeu1-cert-validation" {
  certificate_arn         = aws_acm_certificate.pacujeu1-certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.pacujeu1-validation-record : record.fqdn]
}

resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = var.lb_arn
  port              = var.secureport
  protocol          = var.protocol
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate_validation.pacujeu1-cert-validation.certificate_arn
 
  default_action {
    type             = "forward"
    target_group_arn = var.lb_target_arn
  }
}
