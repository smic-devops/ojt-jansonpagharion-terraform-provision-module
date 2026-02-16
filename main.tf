module "security" {
  source      = "./modules/security"
  vpc_id      = var.vpc_id
  sg_alb_name = "${var.app_name}-sg-alb-module"
  sg_ec2_name = "${var.app_name}-sg-ec2-module"
  sg_rds_name = "${var.app_name}-sg-rds-module"
}

module "alb" {
  source                     = "./modules/alb"
  alb_name                   = "${var.app_name}-alb-module"
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
  target_group_arn = module.alb.target_group_arns["http_80"]
}


module "rds" {
  source            = "./modules/rds"
  private_subnet2   = var.private_subnet2
  private_subnet    = var.private_subnet
  subnet_group_name = "${var.app_name}subnet-group-module"
  rds_sg_id         = module.security.rds_sg_id
  db_engine         = var.db_engine
  db_engine_version = var.db_engine_version
  db_instance_class = var.db_instance_class
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
}