variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "sg_name" {
  type        = string
  description = "Security group name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR Block"
}