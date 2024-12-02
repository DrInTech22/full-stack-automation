resource "local_file" "ansible_inventory" {
  filename = "../ansible/inventory.ini"
  content  = <<EOF
    [web_servers]
    ${aws_instance.ec2.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${var.private_key_path}
  EOF
}

resource "null_resource" "run_ansible" {
  depends_on = [null_resource.verify_dns_resolution, local_file.ansible_inventory]

  provisioner "local-exec" {
    command = <<EOT
      echo "Domains propagated. Running Ansible playbook..."
      sleep 10
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../ansible/inventory.ini ../ansible/playbook.yml \
      --extra-vars "frontend_domain=${var.frontend_domain} db_domain=${var.db_domain} traefik_domain=${var.traefik_domain} cert_email=${var.cert_email}"
    EOT
  }
}

resource "null_resource" "verify_dns_resolution" {
  provisioner "local-exec" {
    command = <<-EOT
      #!/bin/bash
      domains="${var.frontend_domain} ${var.db_domain} ${var.traefik_domain} www.${var.frontend_domain} www.${var.db_domain} www.${var.traefik_domain}"
      instance_ip="${aws_instance.ec2.public_ip}"
      echo " "
      echo "--------------------------------------------------------"  
      echo "$instance_ip should point to domains: $domains"
      echo "---------------------------------------------------------"
      echo " "
      # Wait for 90 seconds (1.5 minutes) to give the user time to set the domains
      echo "Waiting for 120 seconds for domains to be configured..."
      sleep 120

      # Start looping through the domains to check resolution
      while true; do
        all_resolved=true

        for domain in $domains; do
          # Perform nslookup using two different DNS servers
          resolved_ip_1=$(nslookup "$domain" 208.67.222.220 | grep 'Address' | tail -n 1 | awk '{print $2}')
          resolved_ip_2=$(nslookup "$domain" 8.8.8.8 | grep 'Address' | tail -n 1 | awk '{print $2}')
              
          # Compare the resolved IPs to the expected instance IP
          if [ "$resolved_ip_1" = "$instance_ip" ] || [ "$resolved_ip_2" = "$instance_ip" ]; then
            echo "Domain $domain resolves correctly to $instance_ip"
          else
            echo "Domain $domain resolves to $resolved_ip_1 but expected $instance_ip"
            all_resolved=false
          fi
        done

        # Check if all domains resolved correctly
        if [ "$all_resolved" = true ]; then
          echo "All domains have propagated correctly to IP $instance_ip"
          break
        else
          echo "Please configure the domains to point to $instance_ip. Retrying in 60 seconds..."
          sleep 60
        fi
      done
    EOT
  }

  depends_on = [aws_instance.ec2]
}
