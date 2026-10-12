instance_type       = "t3.micro"
availability_zone   = "us-east-1a"
volume_size         = 10
security_group_name = "example-security-group"
ingress_rule        = {
    ssh = {
        from_port   = 22
        to_port     = 22
        protocol    = "ssh"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
egress_rule         = {
    all_traffic = {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}