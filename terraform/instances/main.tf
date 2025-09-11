# Public EC2 Instance
resource "aws_instance" "redis-public" {
  ami                         = var.ami-id
  instance_type               = var.instance-type
  subnet_id                   = var.pub-sub-id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.public-sg-id]
  key_name                    = var.key-name

  

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/install.sh",
      "bash /home/ubuntu/install.sh",
      "echo 'Install script executed successfully!'"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/var/lib/jenkins/ninja.pem")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "redis-public"
  }
}

# Private EC2 Instances
resource "aws_instance" "redis-private-1" {
  ami                         = var.ami-id
  instance_type               = var.instance-type
  subnet_id                   = var.pri-sub-1-id
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.private-sg-id]
  key_name                    = var.key-name

  tags = {
    Name = "redis-private-1"
  }
}

resource "aws_instance" "redis-private-2" {
  ami                         = var.ami-id
  instance_type               = var.instance-type
  subnet_id                   = var.pri-sub-2-id
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.private-sg-id]
  key_name                    = var.key-name

  tags = {
    Name = "redis-private-2"
  }
}

resource "aws_instance" "redis-private-3" {
  ami                         = var.ami-id
  instance_type               = var.instance-type
  subnet_id                   = var.pri-sub-3-id
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.private-sg-id]
  key_name                    = var.key-name

  tags = {
    Name = "redis-private-3"
  }
}
