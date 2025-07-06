variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

# variable "subnet_names" {
#   type        = list(string)
#   description = "Subnet AZ Names"
# }


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
  description = "Private Subnet Names"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR Blocks"
}

# variable "public_subnet_names" {
#   type        = list(string)
#   description = "Public Subnet Names"
# }

variable "subnet_az_names" {
  type        = list(string)
  description = "Subnet AZ Names"
}

# variable "subnet_cidrs" {
#   type        = list(string)
#   description = "Subnet CIDR Blocks"
# }


