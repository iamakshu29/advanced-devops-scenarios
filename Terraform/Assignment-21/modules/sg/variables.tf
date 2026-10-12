variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "example-security-group"
}


variable "ingress_rule" {
  description = "Ingress rules for the security group"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {}
}

variable "egress_rule" {
  description = "Egress rules for the security group"
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = {}
}