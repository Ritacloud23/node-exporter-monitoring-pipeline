# VPC Resource
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  # Customize the CIDR block as needed
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Main-VPC"
  }
}