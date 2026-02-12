module "security" {
  source      = "./modules/security"
  vpc_id      = var.vpc_id
  sg_alb_name = var.sg_alb_name
  sg_ec2_name = var.sg_ec2_name
}

module "alb" {
  source                     = "./modules/alb"
  alb_name                   = var.alb_name
  vpc_id                     = var.vpc_id
  public_subnet1             = var.public_subnet1
  public_subnet2             = var.public_subnet2
  alb_sg_id                  = module.security.alb_sg_id
  listener                   = var.listener
  alb_internal               = var.alb_internal
  alb_load_balancer_type     = var.alb_load_balancer_type
  enable_deletion_protection = var.enable_deletion_protection
}


module "ec2" {
  source           = "./modules/ec2"
  ec2_sg_id        = module.security.ec2_sg_id
  vpc_id           = var.vpc_id
  private_subnet   = var.private_subnet
  ec2_name         = "${var.app_name}-ec2-module"
  ami              = var.ami
  instance_type    = var.instance_type
  target_group_arn = module.alb.alb_tg_arn
} 