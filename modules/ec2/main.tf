resource "aws_instance" "ec2_b" {
  ami                         = data.ubuntu.id
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
