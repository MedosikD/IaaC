resource "aws_vpc" "project_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "project-main-VPC"
  }
}












