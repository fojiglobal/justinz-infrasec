resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name        = "${var.env}-vpc"
    Environment = var.env
  }
}

####### Subnets #######
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  for_each                = var.public_subnets
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["azs"]
  tags                    = each.value["tags"]
  map_public_ip_on_launch = var.map_public_ip
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  for_each          = var.private_subnets
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["azs"]
  tags              = each.value["tags"]
}


####### Internet and Nat gateway ######

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public[var.pub-sub-name].id
  depends_on    = [aws_internet_gateway.this]
  tags = {
    Name = "${var.env}-ngw"
  }
}

resource "aws_eip" "this" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.this]
  tags = {
    Name = "${var.env}-eip"
  }
}

###### Route Tables ####
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = var.all_ipv4_cidr
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "${var.env}-pub-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block     = var.all_ipv4_cidr
    nat_gateway_id = aws_nat_gateway.this.id
  }
  tags = {
    Name = "${var.env}-priv-rt"
  }
}


##### Subnet Associations to the Route table  #######

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  for_each       = var.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
}

resource "aws_route_table_association" "private" {
  route_table_id = aws_route_table.private.id
  for_each       = var.private_subnets
  subnet_id      = aws_subnet.private[each.key].id
}
