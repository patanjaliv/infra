resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  # Must be enabled for EFS
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}
resource "aws_route" "main_to_patanjali" {
  route_table_id            = "rtb-0ee8aba09e29df2f2" # ID of the private route table in the main VPC
  destination_cidr_block    = "9.0.0.0/16" # CIDR block of the patanjali VPC
  transit_gateway_id        = "tgw-0c007573c67029277" # ID of the Transit Gateway
}
