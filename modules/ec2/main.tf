resource "aws_instance" "ec2_ins" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [var.ec2_sg_id]
  subnet_id     = var.private_subnet

  tags = {
    Name = var.ec2_name
  }

}

resource "aws_lb_target_group_attachment" "ec2_attachment" {
  target_group_arn = module.alb.target_group_arn
  target_id        = aws_instance.ec2_ins.id
  port             = 80
  
}