module "ec2" {
  source            = "git::https://github.com/iamakshu29/advanced-devops-scenarios.git//Terraform/Assignment-21/modules/ec2?ref=82d3726b73908aaf28040b5c1b8007fba9e26859"
  ami_filter        = var.ami_filter
  ami_owners        = var.ami_owners
  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  security_group_id = module.sg.security_group_id
  ebs_volume_id     = module.ebs.ebs_volume_id
}

module "ebs" {
  source            = "git::https://github.com/iamakshu29/advanced-devops-scenarios.git//Terraform/Assignment-21/modules/ebs?ref=82d3726b73908aaf28040b5c1b8007fba9e26859"
  availability_zone = var.availability_zone
  volume_size       = var.volume_size
}

module "sg" {
  source              = "git::https://github.com/iamakshu29/advanced-devops-scenarios.git//Terraform/Assignment-21/modules/sg?ref=82d3726b73908aaf28040b5c1b8007fba9e26859"
  security_group_name = var.security_group_name
  ingress_rule        = var.ingress_rule
  egress_rule         = var.egress_rule
}