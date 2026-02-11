
#ALB
variable "name" {
  description = "The name of the load balancer"
  type        = string
}

variable "internal" {
  description = "Whether the load balancer is internal or external"
  type        = bool
}

variable "load_balancer_type" {
  description = "The type of load balancer (application or network)"
  type        = string
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection is enabled"
  type        = bool
}

# Change, multiple tags
variable "tags" {
  description = "Tags to apply to the load balancer"
  type        = map(string)
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