resource "aws_cloudwatch_log_group" "prometheus_patanjali" {
  name              = "/aws/prometheus/patanjali"
  retention_in_days = 14
}

resource "aws_prometheus_workspace" "patanjali" {
  alias = "patanjali"

  logging_configuration {
    log_group_arn = "${aws_cloudwatch_log_group.prometheus_patanjali.arn}:*"
  }
}
