data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "public_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = values(var.public_subnet_ids)[0]
  key_name                    = "stackcouture-key"
  vpc_security_group_ids      = [var.sg_id]
  availability_zone           = var.az_name
  associate_public_ip_address = true
  root_block_device {
    volume_size = 8     # in GiB
    volume_type = "gp3" # General Purpose SSD
  }
  ebs_block_device {
    device_name           = "/dev/sdf"
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = {
    Name = var.instance_tag
  }
}
