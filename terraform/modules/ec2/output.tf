output "public_dns" {
  value     = aws_instance.project_instance.public_dns
  sensitive = true
}
