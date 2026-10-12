module "ec2" {
  source            = "./modules/ec2"
  ami_filter        = var.ami_filter
  ami_owners        = var.ami_owners
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  security_group_id = module.sg.security_group_id
  ebs_volume_id     = module.ebs.ebs_volume_id
}

module "ebs" {
  source            = "./modules/ebs"
  availability_zone = var.availability_zone
  volume_size       = var.volume_size
}

module "sg" {
  source              = "./modules/sg"
  security_group_name = var.security_group_name
  ingress_rule        = var.ingress_rule
  egress_rule         = var.egress_rule
}