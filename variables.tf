variable "aws_region" {
  type        = string
  description = "Server location"
  default     = "eu-west-1"
}


variable "db_name" {
  type        = string
  description = "Desired name for your database"
}

variable "db_username" {
  type        = string
  description = "Postgresql Database user name"
}

variable "db_pass" {
  type        = string
  description = "Postgresql database password"
}

variable "ec2_key_name" {
  type        = string
  description = "EC2 key name from AWS"
}

variable "ec2_security_group_name" {
  type        = string
  description = "Name for your security group"
}

variable "db_security_group_name" {
  type        = string
  description = "Name for your security group"
}
