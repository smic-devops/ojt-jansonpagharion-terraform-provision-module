# Name Tag

variable "app_name" {
  description = "Base name for all resources"
  type        = string
}

# Subnet and VPC variables

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet1" {
  description = "The ID of the first public subnet"
  type        = string
}

variable "public_subnet2" {
  description = "The ID of the second public subnet"
  type        = string
}

variable "private_subnet" {
  description = "The ID of the private subnet"
  type        = string
}

# ALB variables

variable "alb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "alb_internal" {
  description = "Whether the load balancer is internal or external"
  type        = bool
}

variable "alb_load_balancer_type" {
  description = "The type of load balancer (application or network)"
  type        = string
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection is enabled"
  type        = bool
}



variable "listeners" {
  description = "Map of ALB listeners to create."
  type = map(object({
    port            = number                       # e.g., 80 or 443
    protocol        = string                       # "HTTP" or "HTTPS"
    tg_port         = number                       # target group port (often 80)
    tg_protocol     = string                       # "HTTP" or "HTTPS"
    tg_name         = string                       # TG name (must be unique & <= 32 chars)
    target_type     = optional(string, "instance") # or "ip", "lambda"
    health_path     = optional(string, "/")
    health_port     = optional(string, "traffic-port")
    health_protocol = optional(string, "HTTP")
    # Only for HTTPS listeners:
    certificate_arn = optional(string)
    ssl_policy      = optional(string, "ELBSecurityPolicy-2016-08")
  }))
}


# Security Group variables

variable "sg_alb_name" {
  description = "The name of the ALB security group"
  type        = string
}

variable "sg_ec2_name" {
  description = "The name of the EC2 security group"
  type        = string
}

# EC2 variables

variable "ami" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
}