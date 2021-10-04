# -- root/main.tf --

module "network" {
  source           = "./network"
  vpc_cidr         = local.vpc_cidr
  access_ip        = var.access_ip
  public_sn_count  = 1
  private_sn_count = 1
  max_subnets      = 10
  security_groups  = local.security_groups
  public_cidrs     = [for i in range(2, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
  private_cidrs    = [for i in range(1, 255, 2) : cidrsubnet(local.vpc_cidr, 8, i)]
}


module "dvwa" {
  source          = "./dvwa"
  instance_count  = "1"
  dvwa_sg    = module.network.dvwa_sg
  public_subnets  = module.network.public_subnets
  instance_type   = "t2.micro"
  vol_size        = "10"
  key_name        = "dvwa"
  public_key_path = "/home/ec2-user/.ssh/id_ed25519.pub"
  datafile        = file("dvwa.sh")
  # user_data_path  = "${path.root}/userdata.tpl"
}


module "bastion" {
  source          = "./bastion"
  instance_count  = "1"
  bastion_sg      = module.network.bastion_sg
  public_subnets  = module.network.public_subnets
  instance_type   = "t2.micro"
  vol_size        = "10"
  key_name        = "bastion"
  public_key_path = "/home/ec2-user/.ssh/id_ed25519.pub"
  datafile        = file("bastion.sh")
  # user_data_path  = "${path.root}/userdata.tpl
}
