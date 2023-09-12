// Setup SSH-key. Keys are also stored as Output values
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Create key-pair and save private key to ./myKey.pem
resource "aws_key_pair" "project_key_pair" {
  key_name   = "ProjectKey"       # Create "myKey" to AWS!!
  public_key = tls_private_key.ssh_key.public_key_openssh

  provisioner "local-exec" { 
    command = "echo '${tls_private_key.ssh_key.private_key_pem}' > ../ProjectKey.pem"
  }
}


resource "aws_security_group" "project_sc" {
    name        = "allow_ssh"
    description = "Allow SSH inbound traffic"
    vpc_id      = var.project_vpc

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }
    // Remove the default rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_instance" "project_instance" {
    ami = var.ec2_ami
    instance_type = var.instance_type
    subnet_id = var.project_subnet
    vpc_security_group_ids = [ aws_security_group.project_sc.id ]
    key_name = aws_key_pair.project_key_pair.key_name
    associate_public_ip_address = true

    tags = {
      Name = "project-ec2-instance"
    }
}


