resource "aws_instance" "jenkins_server" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"
  key_name      = "jenkins-key" # ADD THIS

  tags = {
    Name = "Jenkins-Server"
  }
}