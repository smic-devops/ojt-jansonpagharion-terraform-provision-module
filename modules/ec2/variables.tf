
variable "ec2_name" {
  description = "Instance Name tag"
  type        = string
}

variable "ami" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}


variable "ec2_sg_id" {
  type = string
}

variable "private_subnet" {
  description = "The ID of the private subnet"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the target group to attach instances to"
  type        = string
}
