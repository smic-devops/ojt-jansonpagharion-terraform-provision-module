# Name Tag
variable "app_name" {
  description = "Base name for all resources"
  type        = string
  default     = "itss-ojt-pagharion"
}

# Subnet and VPC variables
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = "vpc-05596861f4ecffdeb"
}

variable "public_subnet1" {
  description = "The ID of the first public subnet"
  type        = string
  default     = "subnet-09c8dbaa942884f5d"
}

variable "public_subnet2" {
  description = "The ID of the second public subnet"
  type        = string
  default     = "subnet-0240a405eaeacc39e"
}

variable "private_subnet" {
  description = "The ID of the private subnet"
  type        = string
  default     = "subnet-095cdc7b816291369"
}

variable "private_subnet2" {
  description = "The ID of the second private subnet"
  type        = string
  default     = "subnet-0ee426ba08e9643d9"
}

# ALB variables
variable "alb_name" {
  description = "The name of the load balancer"
  type        = string
  default     = "itss-ojt-pagharion-alb-module"
}

variable "alb_internal" {
  description = "Whether the load balancer is internal or external"
  type        = bool
  default     = false
}

variable "alb_load_balancer_type" {
  description = "The type of load balancer (application or network)"
  type        = string
  default     = "application"
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection is enabled"
  type        = bool
  default     = true
}



variable "listener" {
  description = "Map of ALB listeners to create, keyed by name (e.g., http_80, https_443)."
  type = map(object({
    port            = number
    protocol        = string
    tg_port         = number
    tg_protocol     = string
    tg_name         = string
    target_type     = optional(string, "instance")
    health_path     = optional(string, "/")
    health_port     = optional(string, "traffic-port")
    health_protocol = optional(string, "HTTP")
  }))
  default = {
    http_80 = {
      port        = 80
      protocol    = "HTTP"
      tg_port     = 80
      tg_protocol = "HTTP"
      tg_name     = "itss-ojt-pagharion-alb-target-group-module"
    }
  }
}



# Security Group variables
variable "sg_alb_name" {
  description = "The name of the ALB security group"
  type        = string
  default     = "itss-ojt-pagharion-alb-security-group-module"
}

variable "sg_ec2_name" {
  description = "The name of the EC2 security group"
  type        = string
  default     = "itss-ojt-pagharion-ec2-security-group-module"
}

variable "sg_rds_name" {
  description = "The name of the RDS security group"
  type        = string
  default     = "itss-ojt-pagharion-rds-security-group-module"
}

# EC2 variables
variable "ami" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "value" # TODO: replace with real AMI ID
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
  default     = "value" # TODO: e.g., "t3.micro"
}

# RDS
variable "db_engine" {
  type        = string
  description = "Database engine type (mysql or postgres)"
  default     = "mysql"
}

variable "db_engine_version" {
  type        = string
  description = "Engine version"
  default     = "8.0"
}

variable "db_instance_class" {
  type        = string
  description = "Instance size for RDS (db.t4g.micro recommended for dev)"
  default     = "db.t4g.micro"
}

variable "db_name" {
  type        = string
  description = "Name of the initial database"
  default     = "appdb"
}

variable "db_username" {
  type        = string
  description = "Database master username"
  default     = "appuser"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Master DB password"
  default     = "example-password"
}