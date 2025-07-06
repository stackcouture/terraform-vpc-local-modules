variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "rt_name" {
  type        = string
  description = "Route Table Name"
}

variable "internet_gateway_id" {
  type        = string
  description = "Internet Gateway Id"
}

variable "subnet_ids" {
  description = "List of subnet IDs to associate with the route table"
  type        = list(string)
}