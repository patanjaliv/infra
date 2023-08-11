resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.patanjali.id

  tags = {
    Name = "igw"
  }
}
