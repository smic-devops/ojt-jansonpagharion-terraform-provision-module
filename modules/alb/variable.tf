
#ALB
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

# Change, multiple ports
variable "port" {
  description = "The port on which the load balancer is listening"
  type        = number
}

variable "protocol" {
  description = "The protocol on which the load balancer is listening"
  type        = string
}


variable "target_type" {
  description = "The target type of the load balancer"
  type        = string
}

variable "alb_target_group_name" {
  description = "The name of the target group for alb"
  type = string
}

##  VPC & Subnets

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