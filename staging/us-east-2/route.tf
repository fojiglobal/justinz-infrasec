resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.staging.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.staging-igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "pub_sub_1" {
  subnet_id      = aws_subnet.staging_Pub_1.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pub_sub_2" {
  subnet_id      = aws_subnet.staging_Pub_2.id
  route_table_id = aws_route_table.pub_rt.id
}

### Private Route table ###
resource "aws_route_table" "pri_rt" {
  vpc_id = aws_vpc.staging.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.staging.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "pri_sub_1" {
  subnet_id      = aws_subnet.staging_Pri_1.id
  route_table_id = aws_route_table.pri_rt.id
}

resource "aws_route_table_association" "Pri_sub_2" {
  subnet_id      = aws_subnet.staging_Pri_2.id
  route_table_id = aws_route_table.pri_rt.id
}

