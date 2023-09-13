// Setup SSH-key. Keys are also stored as Output values
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Create key-pair and save private key to ./ProjectKey.pem
resource "aws_key_pair" "project_key_pair" {
  key_name   = "ProjectKey"       # Create "myKey" to AWS!!
  public_key = tls_private_key.ssh_key.public_key_openssh

  provisioner "local-exec" { 
    command = "echo '${tls_private_key.ssh_key.private_key_pem}' > ../ansible/files/ProjectKey.pem && chmod 600 ../ansible/files/ProjectKey.pem "
  }
}


// Create Security Group
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

resource "aws_security_group_rule" "expose-3000" {
    security_group_id = aws_security_group.project_sc.id
    type = "ingress"
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "expose-5050" {
    security_group_id = aws_security_group.project_sc.id
    type = "ingress"
    from_port = 5050
    to_port = 5050
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

resource "terraform_data" "run_ansible_playbook" {
      triggers_replace = [
    # The provisioner is executed every time when the `public_ip` of the EC2 instance changes
    aws_instance.project_instance.public_ip
  ]

  provisioner "local-exec" {
     working_dir = "../ansible/"
     command = "ansible-playbook -i hosts playbook.yaml --extra-vars \"ansible_host=${aws_instance.project_instance.public_ip}\" --extra-vars \"unsplash_key=${var.unsplash_key}\" --extra-vars \"ec2_ip=${aws_instance.project_instance.public_ip}\""
  }
}

