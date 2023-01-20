resource "aws_db_instance" "rds_admintable" {
  allocated_storage    = 10
  db_name              = var.dbname
  engine               = "mysql"
  engine_version       = "8.0.28"
  port                 = 3306
  publicly_accessible  = true
  instance_class       = "db.t2.micro"
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true

}