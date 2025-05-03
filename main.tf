provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

# Security Group
resource "aws_security_group" "ubuntu_sg" {
  name        = "ubuntu-sg"
  description = "Allow common ports"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTP
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # HTTPS
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6664
    to_port     = 6664
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # All TCP (optional if you want full open)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Ubuntu Security Group"
  }
}

# 3 EC2 Instances with Ubuntu
resource "aws_instance" "ubuntu_instance" {
  count         = 3
  ami           = "ami-084568db4383264d4"  # Your AMI ID for Ubuntu 22.04 in us-east-1
  instance_type = "t2.micro"
  key_name      = "hello"  # Your key pair name without the .pem extension

  vpc_security_group_ids = [aws_security_group.ubuntu_sg.id]

  root_block_device {
    volume_size = 20   # 20 GB EBS volume
    volume_type = "gp2"
  }

  tags = {
    Name = "Ubuntu-TF-${count.index + 1}"
  }
}
