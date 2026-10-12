data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = var.ami_filter
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = var.ami_owners

}

resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  vpc_security_group_ids = [var.security_group_id]
  tags = {
    Name = "example-instance"
  }
}

resource "aws_volume_attachment" "example" {
  device_name = "/dev/sdh"
  volume_id   = var.ebs_volume_id
  instance_id = aws_instance.example.id
}