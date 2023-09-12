resource "local_file" "hosts" {
    content = <<-EOF
              ec2_webserver ansible_host=${module.project_ec2.public_dns} ansible_user=ec2-user ansible_ssh_private_key_file=../ProjectKey.pem
              EOF
    filename = "../ansible/hosts"
}