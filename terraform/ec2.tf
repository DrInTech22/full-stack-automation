resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = var.ec2_name
  }

  provisioner "local-exec" {
    command = "echo 'Instance provisioned: ${self.public_ip}'"
  }
}


