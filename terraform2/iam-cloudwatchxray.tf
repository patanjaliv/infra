resource "aws_iam_role" "patanjali" {
  name               = "patanjali"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}
 resource "aws_iam_role_policy_attachment" "patanjali-cloudwatch-logs" {
  role       = aws_iam_role.patanjali.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}
 resource "aws_iam_role_policy_attachment" "patanjali-cloudwatch-agent" {
  role       = aws_iam_role.patanjali.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
 resource "aws_iam_role_policy_attachment" "patanjali-xray" {
  role       = aws_iam_role.patanjali.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
}