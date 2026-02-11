variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "sg_alb_name" {
  description = "The name of the ALB security group"
  type        = string
}

variable "sg_ec2_name" {
  description = "The name of the EC2 security group"
  type        = string
}