output "lb-tg" {
    value = aws_lb_target_group.stg-target_grp.arn
}

output "lb-dns" {
    value = aws_lb.stg-lb.dns_name
}

output "lb-zone_id" {
    value = aws_lb.stg-lb.zone_id
}

output "lb-arn" {
    value = aws_lb.stg-lb.arn
}

