resource "terraform_data" "run_ansible_playbook" {
  triggers_replace = [
    # The provisioner is executed every time when the `public_ip` of the EC2 instance changes
    aws_instance.project_instance.public_ip
  ]

  provisioner "local-exec" {
    working_dir = "../ansible/"
    command     = "ansible-playbook -i hosts playbook.yaml --extra-vars \"ansible_host=${aws_instance.project_instance.public_ip}\" --extra-vars \"unsplash_key=${var.unsplash_key}\" --extra-vars \"ec2_ip=${aws_instance.project_instance.public_ip}\""
  }
}