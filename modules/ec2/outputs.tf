# output.tf
output "ec2_public_ip" {
  value = aws_instance.nginx-webserver.public_ip  # Replace with your actual instance resource
  description = "The public IP address of the EC2 instance"
}