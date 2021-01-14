resource "aws_db_instance" "db" {
    allocated_storage    = 20
    storage_type         = "gp2"    # General Purpose SSD
    engine               = "mysql" 
    engine_version       = "8.0"    # mysql v8.0
    instance_class       = "db.t2.micro"
    name                 = "Terraform SQL DataBase"
    username             = "Terraom"
    password             = "password"
    tag                  = {
        Name = "SQL Database" 
    }
    
}
