# Create Ansible inventory file
resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory.ini"
  content  = <<EOF
[web_servers]
${aws_instance.ec2.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${var.private_key_path}
EOF
}

# Run the Ansible playbook
resource "null_resource" "run_ansible" {
  depends_on = [
    aws_route53_record.frontend_record,
    aws_route53_record.www_frontend_record,
    aws_route53_record.db_record,
    aws_route53_record.www_db_record,
    aws_route53_record.traefik_record,
    aws_route53_record.www_traefik_record,
    local_file.ansible_inventory
  ]
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yml --extra-vars 'frontend_domain=${var.frontend_domain} db_domain=${var.db_domain} traefik_domain=${var.traefik_domain} cert_email=${var.cert_email}'"
  }
}
