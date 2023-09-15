resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

// Create key-pair and save private key to ./ProjectKey.pem (default)
resource "aws_key_pair" "project_key_pair" {
  key_name   = "ProjectKey" # Create "myKey" to AWS!!
  public_key = tls_private_key.ssh_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.ssh_key.private_key_pem}' > ${var.ssh_key_path}${var.ssh_key_name}.pem && chmod 600 ${var.ssh_key_path}${var.ssh_key_name}.pem"
  }

}