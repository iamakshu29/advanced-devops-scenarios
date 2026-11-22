resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion_server"
  }
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Only Allow SSH Port"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "bastion_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_from_local" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_bastion" {
  security_group_id = aws_security_group.bastion_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
