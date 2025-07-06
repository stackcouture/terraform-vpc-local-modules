module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  vpc_instance_tenancy = var.instance_tenancy
  vpc_name             = var.vpc_name
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

module "subnet" {
  source          = "./modules/subnets"
  vpc_id          = module.vpc.vpc_id
  public_subnet_names    = var.public_subnet_names
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_names    = var.private_subnet_names
  private_subnet_cidrs    = var.private_subnet_cidrs

  subnet_az_names = var.subnet_az_names
}

module "igw" {
  source   = "./modules/igw"
  vpc_id   = module.vpc.vpc_id
  igw_name = var.igw_name
}

module "rt" {
  source              = "./modules/rt"
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.subnet.subnet_ids
  internet_gateway_id = module.igw.igw_id
  rt_name             = var.rt_name
}

module "sg" {
  source = "./modules/sg"
  vpc_id              = module.vpc.vpc_id
  vpc_cidr_block =      module.vpc.vpc_cidr_block
  sg_name = var.sg_name
}