provider "aws" {
  region = var.aws_region
}

# Data to get default VPC and security group
data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my_db_sg" {
  name   = "db-sg"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${aws_instance.bastion_test.private_ip}/32"] # instance private IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [aws_instance.bastion_test]
}



resource "aws_db_instance" "my_db" {
  allocated_storage   = 5
  db_name             = "testdb"
  engine              = "postgres"
  engine_version      = "14.8"
  instance_class      = "db.t3.micro"
  username            = var.db_username
  password            = var.db_pass
  port                = "5432"
  skip_final_snapshot = true
  storage_encrypted   = false
  apply_immediately   = true

  vpc_security_group_ids = [aws_security_group.my_db_sg.id]

  depends_on = [aws_security_group.my_db_sg]
}


resource "aws_instance" "bastion_test" {
  ami           = "ami-01dd271720c1ba44f"
  instance_type = "t2.micro"

  vpc_security_group_ids      = [aws_security_group.bastion-sg.id]
  associate_public_ip_address = true

  key_name = "bastion-key"
}
