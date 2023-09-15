# IaaC Project
This project contains Terraform code that creates an EC2 instance with all necessary configuration (VPC, subnet, internet gateway, route table, security group) on AWS and deploy the Image Gallery Application on it. 

Source code pf Application: https://github.com/MedosikD/docker-image-gallery

P.S. For this IaaC project we use updated docker-compose.yml file only which pull images of both services (Api and Frontend) from public DockerHub repositories - medosik/api:2.0 and medosik/frontend:2.0 


# Prerequisites
- AWS account with created user.
- Terraform and Ansible installed on local machine (Terraform >= 1.5.7; Ansible >= 2.12).


# Initial configuration
- Create account at the https://unsplash.com
- At the https://unsplash.com/oauth/applications create new demo application with title "Images Gallery". Demo applications are limited to 50 requests per hour
- In the newly created application find section "Keys" and copy Access Key. We will need it further.


# Getting Started
1. Clone the repository:
```
$ git clone https://github.com/MedosikD/IaaC.git
```
2. Navigate to the terraform directory
```
$ cd IaaC/terraform
```
3. Create a file terraform.tfvars in the terraform directory, and fill it with these variables:

Required variables:
```
access_key = "your_aws_access_key"
secret_key = "your_aws_secret_key"
unsplash_key = "Paste_the_Access_Key_from_Unsplash_here"
```

Optional variables:
```
region = "your_aws_region"
// default - eu-central-1

vpc_cidr_block = "your_vpc_cidr_block"
// default - 10.10.0.0/16

subnet_cidr_block = ["subnet_1_cidr_block", "subnet_2_cidr_block"]
// default - [ "10.10.10.0/24", "10.10.11.0/24" ]

availability_zone = ["your_availability_zone_1", "your_availability_zone_2"]
// default - ["eu-central-1a", "eu-central-1b"]

instance_type = "your_instance_type"
// default - t2.micro
```

4. Run `terraform init` to initialize the Terraform environment and download the necessary provider plugins.
5. Run `terraform plan` to see the changes that will be made to your AWS account.
6. Run `terraform apply` to create the resources.

You can access application by using the public IP of the EC2 on port 3000.

7. You can delete the resources by running `terraform destroy`.