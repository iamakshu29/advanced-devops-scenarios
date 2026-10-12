resource "aws_security_group" "example" {
  name        = var.security_group_name
  description = "Example security group"

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_security_group_rule" "example_ingress" {
  type        = "ingress"
  for_each    = var.ingress_rule
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = each.value.cidr_blocks

  security_group_id = aws_security_group.example.id
}

resource "aws_security_group_rule" "example_egress" {
  type        = "egress"
  for_each    = var.egress_rule
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = each.value.cidr_blocks

  security_group_id = aws_security_group.example.id
}
