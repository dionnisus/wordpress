###Create a VPC named ‘wordpress-vpc’ (add name tag).

resource "aws_vpc" "wordpress-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "wordpress-vpc"
  }
}

###Create an Internet Gateway named ‘wordpress_igw’ (add name tag).

resource "aws_internet_gateway" "wordpress_igw" {
  vpc_id = aws_vpc.wordpress-vpc.id #dynamically attaching the IG to my vpc ID(wordpress-vpc)

  tags = {
    Name = "wordpress_igw"
  }
}

###Create a route table named ‘wordpess-rt’ and add Internet Gateway route to it (add name tag).

resource "aws_route_table" "wordpress-rt" {
  vpc_id = aws_vpc.wordpress-vpc.id # attaching dynamically Internet Gateway

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wordpress_igw.id
  }

  tags = {
    Name = "wordpress-rt"
  }
}




### Creating a Nat Gateway for the private subnets to have acces to Internet

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pub_sub_3.id

  tags = {
    Name = "nat-gw"
  }
}
resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.wordpress_igw]

  tags = {
    Name = "nat_eip"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.wordpress-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "private_rt"
  }
}











# Create an EC2 instance named ‘wordpress-ec2’ (add name tag).
# Use Amazon Linux 2 AMI (can store AMI in a variable), t2.micro;
# ‘wordpress-sg’ security group, ‘ssh-key’ key pair, public subnet 1.


resource "aws_instance" "wordpress_ec2" {
  ami             = var.ami_id
  instance_type   = "t3.micro"
  # vpc_id = aws_vpc.wordpress-vpc.id
  key_name        = aws_key_pair.ssh-key.key_name
  subnet_id       = aws_subnet.pub_sub_1.id
  security_groups = [aws_security_group.wordpress-sg.id]

  tags = {
    Name = "wordpress-ec2"
  }
}


