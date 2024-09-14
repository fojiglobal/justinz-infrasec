################# Public subnets #############
resource "aws_subnet" "staging_Pub_1" {
  vpc_id                  = aws_vpc.staging.id
  cidr_block              = "10.30.10.0/24"
  availability_zone       = var.use2a
  map_public_ip_on_launch = true

  tags = {
    Name = "staging-Pub-1"
  }
}

resource "aws_subnet" "staging_Pub_2" {
  vpc_id                  = aws_vpc.staging.id
  cidr_block              = "10.30.20.0/24"
  availability_zone       = var.use2b
  map_public_ip_on_launch = true

  tags = {
    Name = "staging-Pub-2"
  }
}
################# Private subnets #############
resource "aws_subnet" "staging_Pri_1" {
  vpc_id            = aws_vpc.staging.id
  cidr_block        = "10.30.30.0/24"
  availability_zone = var.use2a

  tags = {
    Name = "staging-Pri-1"
  }
}

resource "aws_subnet" "staging_Pri_2" {
  vpc_id            = aws_vpc.staging.id
  cidr_block        = "10.30.40.0/24"
  availability_zone = var.use2b

  tags = {
    Name = "staging-Pri-2"
  }
}
