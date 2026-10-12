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

variable "security_group_id" {
  description = "The ID of the security group to associate with the EC2 instance"
  type        = string
}

variable "ebs_volume_id" {
  description = "The ID of the EBS volume to attach to the EC2 instance"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone in which to launch the EC2 instance"
  type        = string
}