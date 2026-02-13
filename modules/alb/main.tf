resource "aws_lb" "alb_main" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_load_balancer_type
  security_groups    = var.alb_sg_id
  subnets            = [var.public_subnet1, var.public_subnet2]

  enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_lb_target_group" "alb_tg" {
  for_each = var.listener

  name        = each.value.tg_name
  port        = each.value.tg_port
  protocol    = each.value.tg_protocol
  target_type = try(each.value.target_type, "instance")
  vpc_id      = var.vpc_id


  health_check {
    path     = try(each.value.health_path, "/")
    port     = try(each.value.health_port, "traffic-port")
    protocol = try(each.value.health_protocol, "HTTP")
  }

}

resource "aws_lb_listener" "alb_listener" {
  for_each = var.listener

  load_balancer_arn = aws_lb.alb_main.arn
  port              = each.value.port
  protocol          = each.value.protocol


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg[each.key].arn
  }
}