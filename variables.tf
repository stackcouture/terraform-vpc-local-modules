variable "repo_full_name" {
  type        = string
  description = "Repo Full name"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
}

variable "instance_tenancy" {
  type        = string
  description = "VPC Instance Tenancy"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS Support"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS Hostnam"
}


# Subnets Variables 

variable "public_subnet_names" {
  type        = list(string)
  description = "Public Subnet Names"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR Blocks"
}

variable "private_subnet_names" {
  type        = list(string)
  description = "Private Subnet AZ Names"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR Blocks"
}

variable "subnet_az_names" {
  type        = list(string)
  description = "Subnet AZ Names"
}

#Internet Gateway 

variable "igw_name" {
  type        = string
  description = "Internet Gateway Name"
}

# NAT Gateway 

variable "nat_gw_name" {
  type        = string
  description = "NAT Gateway Name"
}


# Route Table

variable "public_rt_name" {
  type        = string
  description = "Route Table Name"
}

variable "private_rt_name" {
  type        = string
  description = "Private Route Table Name"
}

# Security Group 

variable "sg_name" {
  type        = string
  description = "Security group name"
}


#EC2 Instance 
variable "instance_type" {
  type        = string
  description = "Instance Type"
}

variable "instance_tag" {
  type        = string
  description = "Instance Tag"
}

variable "private_instance_tag" {
  type = string 
  description = "Private Instance Tag"
}