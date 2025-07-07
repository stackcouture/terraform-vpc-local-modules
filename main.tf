module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  vpc_instance_tenancy = var.instance_tenancy
  vpc_name             = var.vpc_name
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

module "subnet" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id
  public_subnet_names  = var.public_subnet_names
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_names = var.private_subnet_names
  private_subnet_cidrs = var.private_subnet_cidrs
  subnet_az_names      = var.subnet_az_names
}

module "igw" {
  source   = "./modules/igw"
  vpc_id   = module.vpc.vpc_id
  igw_name = var.igw_name
}

module "rt" {
  source              = "./modules/rt"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.subnet.public_subnet_ids
  private_subnet_ids  = module.subnet.private_subnet_ids
  internet_gateway_id = module.igw.igw_id
  #nat_gateway_id      = module.nat.nat_gateway_id
  public_rt_name  = var.public_rt_name
  private_rt_name = var.private_rt_name
}

module "sg" {
  source         = "./modules/sg"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr_block = module.vpc.vpc_cidr_block
  sg_name        = var.sg_name
}

# module "nat" {
#   source            = "./modules/nat"
#   vpc_id            = module.vpc.vpc_id
#   nat_gw_name       = var.nat_gw_name
#   iwg_id            = module.igw.igw_id
#   public_subnet_ids = module.subnet.public_subnet_ids
# }

module "ec2" {
  source = "./modules/ec2"
  instance_type = var.instance_type
  instance_tag = var.instance_tag
  public_subnet_ids = module.subnet.public_subnet_ids
  #sg_id = module.security_group_id.sg_id
  sg_id = module.sg.sg_id
  az_name = var.subnet_az_names[0]
}