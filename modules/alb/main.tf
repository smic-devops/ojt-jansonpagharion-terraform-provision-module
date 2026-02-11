resource "aws_lb" "name" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_load_balancer_type
  security_groups    = [var.alb_security_group_id]
  subnets            = [var.public_subnet1, var.public_subnet2]

  enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_lb_target_group" "alb_tg" {
  for_each = var.listeners

  name        = each.value.tg_name
  port        = each.value.tg_port
  protocol    = each.value.tg_protocol
  vpc_id      = var.vpc_id
  target_type = coalesce(each.value.target_type, "instance")

  health_check {
    path     = coalesce(each.value.health_path, "/")
    port     = coalesce(each.value.health_port, "traffic-port")
    protocol = coalesce(each.value.health_protocol, "HTTP")
    matcher  = "200-399"
  }

  tags = {
    Name = "tg-${each.value.tg_name}"
  }
}

resource "aws_lb_listener" "alb_listener" {
  for_each          = var.listeners
  load_balancer_arn = aws_lb.alb.arn
  port              = each.value.port
  protocol          = each.value.protocol


  certificate_arn = try(each.value.certificate_arn, null)
  ssl_policy      = try(each.value.ssl_policy, null)

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg[each.key].arn
  }
}