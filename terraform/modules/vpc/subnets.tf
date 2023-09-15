resource "aws_subnet" "project_subnet" {
  vpc_id            = aws_vpc.project_vpc.id
  count             = length(var.subnet_cidr_block)
  cidr_block        = var.subnet_cidr_block[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    Name = "project-subnet"
  }
}