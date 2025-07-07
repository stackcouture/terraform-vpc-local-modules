variable "instance_type" {
  type        = string
  description = "Instance Type"
}

variable "instance_tag" {
  type        = string
  description = "Instance Tag"
}

variable "public_subnet_ids" {
  type = map(string)
}

variable "sg_id" {
  type        = string
  description = "Security Group ID"
}

variable "az_name" {
  type        = string
  description = "Az name"
}

variable "private_instance_tag" {
  type = string 
  description = "Private Instance Tag"
}

variable "private_subnet_ids" {
  type = map(string)
}