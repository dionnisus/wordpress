# Create a MySQL DB instance named ‘mysql’: 20GB, gp2, t2.micro instance class -
# - username=admin, password=adminadmin.
# Use ‘aws_db_subnet_group’ resource to define private subnets where the DB instance will be created.



resource "aws_db_instance" "mysql" {
  identifier             = "mysql"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  # engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "adminadmin"
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds-sg.id]

  skip_final_snapshot = true # Set to `false` if you want backups before deletion

  tags = {
    Name = "mysql"
  }
}


resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "mysql_subnet_group"
  subnet_ids = [aws_subnet.priv_sub_1.id, aws_subnet.priv_sub_2.id, aws_subnet.priv_sub_3.id]

  tags = {
    Name = "mysql_subnet_group"
  }
}