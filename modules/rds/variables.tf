variable "subnet_group_name" {
  description = "Name of the RDS subnet group"
  type        = string
}

variable "private_subnet" {
  description = "The ID of the private subnet"
  type        = string
}

variable "private_subnet2" {
  description = "The ID of the second private subnet"
  type        = string
}

# SG

variable "rds_sg_id" {
  type = string
}

## RDS variables

variable "db_engine" {
  type        = string
  description = "Database engine type (mysql or postgres)"
}

variable "db_engine_version" {
  type        = string
  description = "Engine version"
}

variable "db_instance_class" {
  type        = string
  description = "Instance size for RDS (db.t4g.micro recommended for dev)"
}

variable "db_name" {
  type        = string
  description = "Name of the initial database"
}

variable "db_username" {
  type        = string
  description = "Database master username"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Master DB password (DO NOT hardcode for production)"
}

