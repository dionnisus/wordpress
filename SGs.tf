### Create a security group named ‘wordpress-sg’ and open HTTP, HTTPS, SSH ports to the Internet (add name tag).
### Define port numbers in a variable named ‘ingress_ports’.


resource "aws_security_group" "wordpress-sg" {
  description = "Dynamically allow HTTP, HTTPS, SSH"
  vpc_id = aws_vpc.wordpress-vpc.id
  #instance_id = aws_instance.wordpress_ec2.id

  dynamic "ingress" {
    for_each = toset(["22", "80", "443", "3306"])
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "wordpress-sg"
  }
}


# # Define ingress ports
# variable "ingress_ports" {
#   type    = list(number)
#   default = [22, 80, 443]  # SSH, HTTP, HTTPS
# }

# # Create the Security Group
# resource "aws_security_group" "wordpress_sg" {
#   name        = "wordpress-sg"
#   description = "Allow HTTP, HTTPS, and SSH"
#   vpc_id      = aws_vpc.wordpress_vpc.id  # Ensure the correct VPC is referenced

#   tags = {
#     Name = "wordpress-sg"
#   }
# }

# # Create security group rules dynamically
# resource "aws_security_group_rule" "ingress" {
#   for_each          = toset(var.ingress_ports)

#   type              = "ingress"
#   from_port         = each.value
#   to_port           = each.value
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]  # Open to the internet
#   security_group_id = aws_security_group.wordpress_sg.id
# }





# Create a security group named ‘rds-sg’ and open MySQL port -
# - and allow traffic only from ‘wordpress-sg’ security group (add name tag).

resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  description = "Allow MySQL access from WordPress EC2"
  vpc_id      = aws_vpc.wordpress-vpc.id

  # ingress {
  #   from_port   = 3306
  #   to_port     = 3306
  #   protocol    = "TCP"
  #security_group_id        = aws_security_group.rds-sg.id 
  #source_security_group_id = aws_security_group.wordpress-sg.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# # Security group rule allowing MySQL (3306) traffic from WordPress SG
 resource "aws_security_group_rule" "rds_ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds-sg.id 
  source_security_group_id = aws_security_group.wordpress-sg.id 
 }


