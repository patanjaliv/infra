locals {
  # AWS key pair name
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html
  key_name = "mykey"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_security_group" "jenkins" {
  name   = "jenkins"
  vpc_id = aws_vpc.patanjali.id

  ingress {
    description = "jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow_all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_security_group" "ansible" {
   name        = "ansible_sg"
   vpc_id = aws_vpc.patanjali.id
   description = "Allow SSH, HTTP, and HTTPS traffic"

   ingress {
    description = "ansible"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow_all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_network_interface" "jenkins" {
  subnet_id       = aws_subnet.public-us-west-2a.id
  security_groups = [aws_security_group.jenkins.id]
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.xlarge"

  key_name = local.key_name

  network_interface {
    network_interface_id = aws_network_interface.jenkins.id
    device_index         = 0
  }

  tags = {
    Name = "jenkins"
  }
}

output "ip" {
  value = aws_instance.jenkins.public_ip
}