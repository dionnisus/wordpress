### Create 3 public and 3 private subnets in the us-east region (add name tag).
### Associate them with the ‘wordpess-rt’ route table.
### What subnets should be associated with the ‘wordpess-rt’ route table? 
### What about other subnets? Use AWS documentation.

##############>>> PUBLIC SUBNETS <<<###############

resource "aws_subnet" "pub_sub_1" {
  vpc_id                  = aws_vpc.wordpress-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_sub_1"
  }
}
resource "aws_route_table_association" "pub_sub_1_association" {
  subnet_id      = aws_subnet.pub_sub_1.id
  route_table_id = aws_route_table.wordpress-rt.id
}

resource "aws_subnet" "pub_sub_2" {
  vpc_id                  = aws_vpc.wordpress-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_sub_2"
  }
}
resource "aws_route_table_association" "pub_sub_2_association" {
  subnet_id      = aws_subnet.pub_sub_2.id
  route_table_id = aws_route_table.wordpress-rt.id
}
resource "aws_subnet" "pub_sub_3" {
  vpc_id                  = aws_vpc.wordpress-vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_sub_3"
  }
}
resource "aws_route_table_association" "pub_sub_3_association" {
  subnet_id      = aws_subnet.pub_sub_3.id
  route_table_id = aws_route_table.wordpress-rt.id
}


##############>>> PRIVATE SUBNETS <<<###############

resource "aws_subnet" "priv_sub_1" {
  vpc_id            = aws_vpc.wordpress-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1d"

  tags = {
    Name = "priv_sub_1"
  }
}
resource "aws_route_table_association" "priv_sub_1" {
  subnet_id      = aws_subnet.priv_sub_1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_subnet" "priv_sub_2" {
  vpc_id            = aws_vpc.wordpress-vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1e"

  tags = {
    Name = "priv_sub_2"
  }
}
resource "aws_route_table_association" "priv_sub_2" {
  subnet_id      = aws_subnet.priv_sub_2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_subnet" "priv_sub_3" {
  vpc_id            = aws_vpc.wordpress-vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1f"

  tags = {
    Name = "priv_sub_3"
  }
}
resource "aws_route_table_association" "priv_sub_3" {
  subnet_id      = aws_subnet.priv_sub_3.id
  route_table_id = aws_route_table.private_rt.id
}
