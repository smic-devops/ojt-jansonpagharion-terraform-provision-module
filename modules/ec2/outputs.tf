output "alb_sg_id" {
  value       = aws_security_group.sg_alb.id
  description = "ALB security group ID"
}

output "ec2_sg_id" {
  value       = aws_security_group.sg_ec2.id
  description = "EC2 security group ID"
}