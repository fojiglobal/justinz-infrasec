############ Public Security Group #################
resource "aws_security_group" "Pub_sg" {
  # ... other configuration ...
  name   = "Public-sg"
  vpc_id = aws_vpc.staging.id
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ## create before destroy rule ###
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "Public-sg"
  }
}

############ Bastion Security Group #################
resource "aws_security_group" "bastion_sg" {
  # ... other configuration ...
  name   = "bastion-sg"
  vpc_id = aws_vpc.staging.id
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ## create before destroy rule ###
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "bastion-sg"
  }
}

############ Private Security Group #################
resource "aws_security_group" "Pri_sg" {
  # ... other configuration ...
  name   = "Private-sg"
  vpc_id = aws_vpc.staging.id
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.Pub_sg.id]
  }
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.Pub_sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ## create before destroy rule ###
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "Private-sg"
  }
}
