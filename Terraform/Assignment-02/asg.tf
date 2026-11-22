resource "aws_launch_template" "test_template" {
  name_prefix   = "test"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<h1>Hello from Zero-Downtime ASG</h1>" > /var/www/html/index.html
              EOF
  )
}

resource "aws_autoscaling_group" "test" {
  name                      = "test-asg"
  availability_zones        = ["us-east-1a", "us-east-1b"]
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  target_group_arns         = [aws_lb_target_group.test.arn]

  instance_maintenance_policy {
    min_healthy_percentage = 100
    max_healthy_percentage = 150
  }

  launch_template {
    id      = aws_launch_template.test_template.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100 # Keep 100% capacity alive during updates
    }
    triggers = ["tag"]
  }


  tag {
    key                 = "Name"
    value               = "test-asg"
    propagate_at_launch = true
  }

  timeouts {
    delete = "5m"
  }
}
