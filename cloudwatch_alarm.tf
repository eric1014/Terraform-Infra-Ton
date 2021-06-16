# Variable for alarm notification
variable "actionitem" {
  description = "Send mail alert"
  default = "arn:aws:sns:us-east-2:788792423310:alarm-terraform"
}

#Create Cloudwatch alarm
resource "aws_cloudwatch_metric_alarm" "bat" {
  alarm_name          = "terraform-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "40"

  dimensions = {
    InstanceId = join("", aws_instance.default.*.id)
  }
	
  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${var.actionitem}"]
}
