resource "aws_ec2_transit_gateway" "tgw" {
  description = "My Transit Gateway"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "main_attachment" {
  vpc_id             = "vpc-0de7f3ad1190cd3fc" # Replace with the VPC ID of the "main" VPC
  subnet_ids         = [
    aws_subnet.public-us-east-1a.id,
    aws_subnet.public-us-east-1b.id]  # Replace with the subnet IDs for the "main" VPC
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
}
output "main_vpc_id" {
  value = aws_vpc.main.id
}
output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.tgw.id
}