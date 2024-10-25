resource "aws_vpc" "test-vpc" {
  cidr_block = "10.11.0.0/16"
  tags = {
    Name        = "qa vpc"
    Environment = "qa"
  }
}
