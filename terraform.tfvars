repo_full_name = "stackcouture/terraform-vpc-local-modules"

vpc_cidr             = "10.0.0.0/16"
instance_tenancy     = "default"
vpc_name             = "My-VPC"
enable_dns_support   = true
enable_dns_hostnames = true


# Subnets 
public_subnet_names = ["Public-Subnet-1", "Public-Subnet-2"]
public_subnet_cidrs = ["10.0.0.0/26", "10.0.0.64/26"]

private_subnet_names = ["Private-Subnet-1", "Private-Subnet-2"]
private_subnet_cidrs = ["10.0.0.128/26", "10.0.0.192/26"]

subnet_az_names = ["ap-south-1a", "ap-south-1b"]

#Internet Gateway 
igw_name    = "VPC-IGW"
nat_gw_name = "VPC-NGW"

#Route Table 
public_rt_name  = "Public-RT"
private_rt_name = "Private-RT"

#Security Group 
sg_name = "Web-SG"


# EC2 Instance 

instance_type = "t2.micro"
instance_tag  = "Public-Server"