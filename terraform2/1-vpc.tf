resource "aws_vpc" "patanjali" {
  cidr_block = "9.0.0.0/16"

  # Must be enabled for EFS
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "patanjali"
  }
}
resource "aws_route" "patanjali_to_main" {
  route_table_id            = "rtb-0df86dd74c4524891" # ID of the private route table in the patanjali VPC
  destination_cidr_block    = "10.0.0.0/16" # CIDR block of the main VPC (replace with the actual CIDR)
  transit_gateway_id        = "tgw-04ccbd8b1cc641e92" # ID of the Transit Gateway
}
