variable "aws_region" {
  type        = string
  description = "Server location"
  default     = "eu-west-1"
}

variable "db_username" {
  type        = string
  description = "Postgresql Database name"
}

variable "db_pass" {
  type        = string
  description = "Postgresql database password"
}
