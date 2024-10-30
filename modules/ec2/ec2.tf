# Create the key pair using the public key from GitHub Actions
resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2-key-pair"
  public_key = var.public_key
}

resource "aws_security_group" "ssh_access" {
  name        = "nginx-webserver-ssh-access"
  description = "Allow SSH access to Nginx web server"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access from all IPs; consider limiting this for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx-webserver" {
  ami             = "ami-06b21ccaeff8cd686"
  instance_type   = "t2.micro"
  subnet_id       = var.public_subnet_id
  security_groups = [aws_security_group.ssh_access.name, var.security_group_id]
  key_name        = aws_key_pair.ec2_key.key_name

  tags = {
    Name = "Nginx Web Server"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install docker -y
    service docker start
    usermod -a -G docker ec2-user
  EOF
}