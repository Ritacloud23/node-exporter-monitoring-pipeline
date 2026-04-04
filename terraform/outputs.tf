output "instance_public_ip" {
  value = aws_instance.jenkins_server.public_ip
}

output "elastic_ip" {
  value = aws_eip.jenkins_eip.public_ip
}