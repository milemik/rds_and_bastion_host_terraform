output "ec2_public_ip" {
  value = aws_instance.bastion_test.public_ip
}

output "db_endpoint" {
  value = aws_db_instance.my_db.endpoint
}
