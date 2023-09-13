module "project_vpc" {
    source = "./modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    subnet_cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
}

module "project_ec2" {
    source = "./modules/ec2"
    ec2_ami = var.ec2_ami
    instance_type = var.instance_type
    project_vpc = module.project_vpc.project_vpc.id
    project_subnet = module.project_vpc.project_subnet.id
    unsplash_key = var.unsplash_key
}
