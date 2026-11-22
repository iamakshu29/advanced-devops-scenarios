resource "aws_autoscaling_policy" "test_policy" {
  name                   = "asg-scaling-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.test.name
}

resource "aws_cloudwatch_metric_alarm" "test_alarm" {
  alarm_name          = "test-asg-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/AutoScaling"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = [aws_autoscaling_policy.test_policy.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.test.name
  }
}
