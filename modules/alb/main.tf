resource "aws_lb" "name" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = module.security.security_groups
  subnets            = module.vpc.public_subnet_ids

  enable_deletion_protection = var.enable_deletion_protection
  tags                       = var.tags
}

resource "aws_lb_target_group" "name" {
  name        = var.name
  port        = var.port
  protocol    = var.protocol
  vpc_id      = module.vpc.vpc_id
  target_type = var.target_type

  tags = var.tags
}

resource "aws_lb_listener" "name" {
  load_balancer_arn = aws_lb.name.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    target_group_arn = aws_lb_target_group.name.arn
    type             = "forward"
  }
}