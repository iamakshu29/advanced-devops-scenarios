resource "aws_instance" "private_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  vpc_security_group_ids = [aws_security_group.private_ec2_sg.id] 

  tags = {
    Name = "private_ec2"
  }
}

resource "aws_security_group" "private_ec2_sg" {
  name        = "private_ec2_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "private_ec2_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_from_bastion" {
  security_group_id = aws_security_group.private_ec2_sg.id
  referenced_security_group_id = aws_security_group.bastion_sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_private" {
  security_group_id = aws_security_group.private_ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}