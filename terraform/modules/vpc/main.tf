resource "aws_vpc" "project_vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    tags = {
        Name = "project-main-VPC"
    }
}

resource "aws_subnet" "project_subnet" {
    vpc_id = aws_vpc.project_vpc.id
    count = "${length(var.subnet_cidr_block)}"
    cidr_block = var.subnet_cidr_block[count.index]
    availability_zone = var.availability_zone[count.index]
    tags = {
        Name = "project-subnet"
    }
}

resource "aws_internet_gateway" "project_igw" {
    vpc_id = aws_vpc.project_vpc.id
    tags = {
      Name = "project-igw"
    }
}

resource "aws_route_table" "project_route_table" {
    vpc_id = aws_vpc.project_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.project_igw.id
    }
    tags = {
      Name = "project-route-table"
    }
}

resource "aws_route_table_association" "project_rt_association" {
    count = "${length(var.subnet_cidr_block)}"
    subnet_id = "${element(aws_subnet.project_subnet.*.id, count.index)}"
    route_table_id = aws_route_table.project_route_table.id
}




