output "project_vpc" {
  value = aws_vpc.project_vpc
}

output "project_subnet" {
  value = aws_subnet.project_subnet[0]
}