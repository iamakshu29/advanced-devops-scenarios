variable "ami_filter" {
  description = "The filter to use when selecting the AMI"
  type        = list(string)
  default     = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
}

variable "ami_owners" {
  description = "The owners of the AMI to use for the EC2 instance"
  type        = list(string)
  default     = ["amazon"]
}

variable "instance_type" {
  description = "The type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "availability_zone" {
  description = "The availability zone in which to create the EBS volume"
  type        = string
  default     = "us-east-1a"
}

variable "volume_size" {
  description = "The size of the EBS volume in GB"
  type        = number
  default     = 10
}

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