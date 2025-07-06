variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

# variable "rt_name" {
#   type        = string
#   description = "Route Table Name"
# }

variable "public_rt_name" {
  type        = string
  description = "Public Route Table Name"
}

variable "private_rt_name" {
  type        = string
  description = "Private Route Table Name"
}

variable "internet_gateway_id" {
  type        = string
  description = "Internet Gateway Id"
}

variable "nat_gateway_id" {
  type        = string
  description = "NAT Gateway ID"
}

variable "public_subnet_ids" {
  description = "List of subnet IDs to associate with the route table"
  type        = map(string)
}

variable "private_subnet_ids" {
  description = "List of subnet IDs to associate with the route table"
  type        = map(string)
}
# variable "private_rt_name" {
#   type        = string
#   description = "Private Route Table Name"
# }