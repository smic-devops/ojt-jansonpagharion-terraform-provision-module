# All Target Group ARNs keyed by listener key (e.g., http_80, https_443)
output "target_group_arns" {
  description = "Map of listener_key => target group ARN"
  value       = { for k, tg in aws_lb_target_group.alb_tg : k => tg.arn }
}

# All Listener ARNs keyed by listener key
output "listener_arns" {
  description = "Map of listener_key => listener ARN"
  value       = { for k, l in aws_lb_listener.alb_listener : k => l.arn }
}

# Convenience outputs
output "alb_arn" {
  description = "ALB ARN"
  value       = aws_lb.alb_main.arn
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.alb_main.dns_name
}