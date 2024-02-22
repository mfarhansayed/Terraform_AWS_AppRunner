resource "aws_db_subnet_group" "private_subnet_group" {
  count      = var.create_postgresdbpvt == true ? 1 : 0
  name       = var.postgresdbpvt_sq_name
  subnet_ids = [aws_subnet.subnet[1].id, aws_subnet.subnet[3].id]
  tags = {
    project = "project_name"
    Name    = "${var.prefix}-${var.private_subnet_group}"
  }
}

#-------------------------------Datablock--------------------------
data "aws_secretsmanager_secret_version" "db_username" {
  secret_id = "/project_name/portal/db_username"
}

data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "/project_name/portal/db_password"
}

#----------------------Locals-------------------------
locals {
  pg_db_username = jsondecode(
    data.aws_secretsmanager_secret_version.db_username.secret_string
  )
}

locals {
  pg_db_password = jsondecode(
    data.aws_secretsmanager_secret_version.db_password.secret_string
  )
}

#----------------------Postgres DB Instance-------------------------
resource "aws_db_instance" "postgres_pvtdb" {
  count                     = var.create_postgresdbpvt == true ? 1 : 0
  engine                    = var.postgresengine     //"postgres"
  engine_version            = var.postgresrdsversion //"14.1"
  identifier                = var.postgresrdsname
  vpc_security_group_ids    = [aws_security_group.rds_postgres_security_group[0].id]
  db_subnet_group_name      = aws_db_subnet_group.private_subnet_group[0].id
  username                  = local.pg_db_username.DB_USERNAME
  password                  = local.pg_db_password.DB_PASSWORD
  instance_class            = var.instance_class_postgres //"db.t3.micro"
  storage_type              = var.postgresstoragetype
  allocated_storage         = var.allocated_storage_postgres //5
  multi_az                  = var.multi_az_postgres
  publicly_accessible       = var.publicly_accessible_postgrespvt //false
  backup_retention_period   = var.retionperiod_postgres
  delete_automated_backups  = var.delete_automated_backups_postgres //true
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot_postgres
  deletion_protection       = var.deletion_protection_postgres
  skip_final_snapshot       = var.skip_final_snapshot_postgres //true
  final_snapshot_identifier = "${var.prefix}-${var.postgres-final-snapshot}"
  tags = {
    project = "project_name"
  }
}




