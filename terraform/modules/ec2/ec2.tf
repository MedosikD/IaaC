resource "aws_instance" "project_instance" {
  ami                         = var.ec2_ami
  instance_type               = var.instance_type
  subnet_id                   = var.project_subnet
  vpc_security_group_ids      = [aws_security_group.project_sc.id]
  key_name                    = aws_key_pair.project_key_pair.key_name
  associate_public_ip_address = true

  tags = {
    Name = "project-ec2-instance"
  }
}