resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_vpc.id
  subnet_id     = values(var.public_subnet_ids)[0]

  tags = {
    Name = "gw NAT"
  }
  depends_on = [var.iwg_id]
}

resource "aws_eip" "eip_vpc" {
  domain = "vpc"
}