resource "aws_lb" "alb_main" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_load_balancer_type
  security_groups    = var.alb_sg_id
  subnets            = [var.public_subnet1, var.public_subnet2]

  enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_lb_target_group" "alb_tg" {
  name        = var.listener.tg_name
  port        = var.listener.tg_port
  protocol    = var.listener.tg_protocol
  vpc_id      = var.vpc_id
  target_type = var.listener.target_type

  health_check {
    path     = var.listener.health_path
    port     = var.listener.health_port
    protocol = var.listener.health_protocol
    matcher  = "200-399"
  }

}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb_main.arn
  port              = var.listener.port
  protocol          = var.listener.protocol

  certificate_arn = try(var.listener.certificate_arn, null)
  ssl_policy      = try(var.listener.ssl_policy, null)

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}