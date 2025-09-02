############
# Database #
############

resource "aws_db_subnet_group" "main" {
  name = "${local.prefix}-main"
  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  tags = {
    Name = "${local.prefix}-db-subnet-group"
  }
}

# security group that is going to allow access to the RDS database instance.
# We've given it a description and a name which allow us to find it in AWS.
# We've put it in our VPC, which we are using as our main VPC.
# And then we're allowing ingress access via the protocol TCP on port 5432. Port 5432 is the default port for Postgres databases.
resource "aws_security_group" "rds" {
  description = "Allow access to the RDS database instance."
  name        = "${local.prefix}-rds-inbound-access"
  vpc_id      = aws_vpc.main.id

  ingress {
    protocol  = "tcp"
    from_port = 5432
    to_port   = 5432
  }

  tags = {
    Name = "${local.prefix}-db-security-group"
  }
}
# So the identifier is essentially the identifier in AWS.
# new postgress database instance with a new name
# auto minor version upgrade is set to true, minor updates by aws, for security
# skip final snapshot is true, so we don't want a snapshot when we delete the database
# backup retention period is set to zero, so we don't want any backups.
resource "aws_db_instance" "main" {
  identifier                 = "${local.prefix}-db"
  db_name                    = "recipe"
  allocated_storage          = 20
  storage_type               = "gp2"
  engine                     = "postgres"
  engine_version             = "15.14"
  auto_minor_version_upgrade = true
  instance_class             = "db.t4g.micro"
  username                   = var.db_username
  password                   = var.db_password
  skip_final_snapshot        = true
  db_subnet_group_name       = aws_db_subnet_group.main.name
  multi_az                   = false
  backup_retention_period    = 0
  vpc_security_group_ids     = [aws_security_group.rds.id]

  tags = {
    Name = "${local.prefix}-main"
  }
}
