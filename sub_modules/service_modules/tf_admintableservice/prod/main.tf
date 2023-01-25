resource "aws_db_instance" "rds_admintable" {
  allocated_storage    = 10
  db_name              = var.admindb_name
  engine               = "mysql"
  engine_version       = "8.0.28"
  port                 = 3306
  publicly_accessible  = false
  instance_class       = "db.t2.micro"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true

}

output "rds_address" {
  value = aws_db_instance.rds_admintable.address
}