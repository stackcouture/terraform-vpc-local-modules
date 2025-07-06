output "public_subnet_ids" {
  value = { for idx, subnet in aws_subnet.public_subnets : "subnet_${idx}" => subnet.id }
}

output "private_subnet_ids" {
  value = { for idx, subnet in aws_subnet.private_subnets : "subnet_${idx}" => subnet.id }
}