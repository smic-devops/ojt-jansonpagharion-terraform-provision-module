# modules/alb/outputs.tf
output "alb_arn" {
  value = aws_lb.alb_main.arn
}

output "alb_dns_name" {
  value = aws_lb.alb_main.dns_name
}

output "target_group_arns" {
  value = { for k, tg in aws_lb_target_group.alb_tg : k => tg.arn }
}