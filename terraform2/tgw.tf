
resource "aws_ec2_transit_gateway" "tgw" {
  description = "My Transit Gateway"
}
resource "aws_ec2_transit_gateway_vpc_attachment" "patanjali_attachment" {
  vpc_id             = "vpc-0a41e19593e0e1ebe"
  subnet_ids         = [
    aws_subnet.public-us-west-2a.id,
    aws_subnet.public-us-west-2b.id
  ]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id 
}

resource "aws_ec2_transit_gateway_peering_attachment" "east-west" {
  peer_region         = "us-east-1" # The region of the other Transit Gateway
  peer_transit_gateway_id = "tgw-0c007573c67029277" # ID of the other Transit Gateway
  transit_gateway_id  = "tgw-04ccbd8b1cc641e92" # ID of the local Transit Gateway
}
