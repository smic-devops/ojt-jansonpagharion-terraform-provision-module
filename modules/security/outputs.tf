output "ec2_sg_id" {
  description = "Security group ID for EC2 instances"
  value       = aws_security_group.sg_ec2.id
}

output "alb_sg_id" {
  description = "Security group ID for ALB"
  value       = aws_security_group.sg_alb.id
}