## ALB Security Group
resource "aws_security_group" "sg_alb" {
    name        = "alb-sg"
    description = "Security group for ALB"
    vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "http_alb" {
    security_group_id = aws_security_group.sg_alb.id
    ip_protocol = "tcp"
    from_port        = 80
    to_port          = 80
    cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "https_alb" {
    security_group_id = aws_security_group.sg_alb.id
    ip_protocol = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id = aws_security_group.sg_alb.id
  referenced_security_group_id = aws_security_group.sg_ec2.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

## EC2 Security Group

resource "aws_security_group" "sg_ec2" {
    name        = "ec2-sg"
    description = "Security group for EC2 instances"
    vpc_id      = module.vpc.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ec2_ingress" {
  security_group_id = aws_security_group.sg_ec2.id
  referenced_security_group_id = aws_security_group.sg_alb.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ec2_egress" {
  security_group_id = aws_security_group.sg_ec2.id
  cidr_ipv4        = "0.0.0.0/0"
  ip_protocol       = "-1"
  
}