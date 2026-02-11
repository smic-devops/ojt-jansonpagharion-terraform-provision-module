
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

variable "alb_sg_id" {
  description = "List of security group IDs to attach to the ALB."
  type        = list(string)
}

## For listener and target group

variable "listeners" {
  description = "Map of ALB listeners to create."
  type = map(object({
    port              = number                 
    protocol          = string                 
    tg_port           = number                 
    tg_protocol       = string                
    tg_name           = string                 
    target_type       = optional(string, "instance") 
    health_path       = optional(string, "/")
    health_port       = optional(string, "traffic-port")
    health_protocol   = optional(string, "HTTP")
  }))
}


##  VPC & Subnets

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}


variable "public_subnet_ids" { 
  type = list(string) 
  
  }
