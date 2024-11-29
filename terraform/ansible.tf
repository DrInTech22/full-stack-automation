resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory.ini"
  content  = <<EOF
[web_servers]
${aws_instance.ec2.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${var.private_key_path}
EOF
}

resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Waiting for server to be ready..."
      sleep 30
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yml
    EOT
  }

  depends_on = [local_file.ansible_inventory, aws_instance.ec2]
}
