output "vpc_id" {
  description = "The VPC ID"
  value       = aws_vpc.vpc_main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs for ALB or public resources"
  value       = [aws_subnet.public1.id, aws_subnet.public2.id]
}

output "private_subnet_ids" {
  description = "Private subnet IDs for EC2/app resources"
  value       = [aws_subnet.private1.id]
}
