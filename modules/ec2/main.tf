resource "tls_private_key" "my_ec2key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "my_ec2key" {
  key_name   = "my-ec2key"
  public_key = tls_private_key.my_ec2key.public_key_openssh
  depends_on = [tls_private_key.my_ec2key]
}

# Save the private key to a local file in .pem format
resource "local_file" "private_key" {
  filename        = "${path.root}/my-ec2key.pem"
  content         = tls_private_key.my_ec2key.private_key_pem
  file_permission = "0400" # Read-only by the owner
}

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
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = values(var.public_subnet_ids)[0]
  key_name      = "stackcouture-key"
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

# resource "aws_instance" "private_instance" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.instance_type
#   subnet_id     = values(var.public_subnet_ids)[0]
#   key_name      = "stackcouture-key"
#   vpc_security_group_ids      = [var.sg_id]
#   availability_zone           = var.az_name
#   associate_public_ip_address = true
#   root_block_device {
#     volume_size = 8     # in GiB
#     volume_type = "gp3" # General Purpose SSD
#   }
#   ebs_block_device {
#     device_name           = "/dev/sdf"
#     volume_size           = 20
#     volume_type           = "gp3"
#     delete_on_termination = true
#   }
#   tags = {
#     Name = var.instance_tag
#   }
# }