variable "access_key" {
  description = "Access Key of AWS account"
}

variable "secret_key" {
  description = "Secret Key of AWS account"
}

variable "unsplash_key" {
  description = "Access key of Unsplash account"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr_block" {
  description = "IPv4 CIDR block for VPC"
  default     = "10.10.0.0/16"
}

variable "subnet_cidr_block" {
  description = "IPv4 CIDR block fro subnet"
  default     = ["10.10.10.0/24", "10.10.11.0/24"]
  type        = list(string)
}

variable "availability_zone" {
  description = "AZs in this region to use"
  default     = ["eu-central-1a", "eu-central-1b"]
  type        = list(string)
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ec2_ami" {
  default = "ami-09cb21a1e29bcebf0"
}





variable "ssh_key_name" {
  default     = "ProjectKey"
  description = "Name of the SSH Key file"
}

variable "ssh_key_path" {
  default     = "../ansible/files/"
  description = "Path to the folder where SSH Key should be stored."
}
