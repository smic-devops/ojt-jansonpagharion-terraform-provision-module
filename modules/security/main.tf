## ALB Security Group
resource "aws_security_group" "sg_alb" {
  name        = var.sg_alb_name
  description = "Security group for ALB"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "http_alb" {
  security_group_id = aws_security_group.sg_alb.id
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "https_alb" {
  security_group_id = aws_security_group.sg_alb.id
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id            = aws_security_group.sg_alb.id
  referenced_security_group_id = aws_security_group.sg_ec2.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

## EC2 Security Group

resource "aws_security_group" "sg_ec2" {
  name        = var.sg_ec2_name
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ec2_ingress" {
  security_group_id            = aws_security_group.sg_ec2.id
  referenced_security_group_id = aws_security_group.sg_alb.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ec2_egress" {
  security_group_id            = aws_security_group.sg_ec2.id
  referenced_security_group_id = aws_security_group.sg_rds.id
  description                  = "Allow EC2 to talk to RDS"
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
}

# RDS Security Group

resource "aws_security_group" "sg_rds" {
  name        = var.sg_rds_name
  description = "Allow DB from EC2 only"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "rds_ingress_from_ec2" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_rds.id
  source_security_group_id = aws_security_group.sg_ec2.id
}

resource "aws_security_group_rule" "rds_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_rds.id
  cidr_blocks       = ["0.0.0.0/0"]
}