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


##### Auto scaling Group #######

resource "aws_launch_template" "lt" {
  name     = "${var.env}-lt"
  image_id = var.ami_id #"ami-085f9c64a9b75eed5"
  #image_id                             = "aws_ami"
  instance_type                        = var.instance_type #"t2.micro"
  instance_initiated_shutdown_behavior = "terminate"
  vpc_security_group_ids               = [aws_security_group.private.id]
  key_name                             = var.instance_key #"cs2-use2-main"
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.env}-web"
    }
  }

  user_data = var.user_data
}

resource "aws_autoscaling_group" "asg" {
  name = "${var.env}-asg"
  #availability_zones = ["us-east-2a", "us-east-2b"]
  vpc_zone_identifier = [for subnet in aws_subnet.private : subnet.id]
  desired_capacity    = var.desired
  max_size            = var.max_size
  min_size            = var.min_size
  #target_group_arns   = [aws_lb_target_group.tgw.arn]
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  tag {
    key                 = "name"
    value               = "${var.env}-web"
    propagate_at_launch = true
  }
}

######Target group #####
resource "aws_lb_target_group" "tg" {
  name     = "${var.env}-tg-80"
  port     = var.alb_port_http
  protocol = var.alb_proto_http
  vpc_id   = aws_vpc.this.id

  tags = {
    Name        = "${var.env}-tg-80"
    Environment = var.env
  }

}
##### Application Load Balancer ####
resource "aws_lb" "alb" {
  name                       = "${var.env}-alb"
  internal                   = var.internet_facing
  load_balancer_type         = var.alb_type
  security_groups            = [aws_security_group.public.id]
  subnets                    = [for subnet in aws_subnet.public : subnet.id]
  drop_invalid_header_fields = true

  tags = {
    Name        = "${var.env}-alb"
    Environment = var.env
  }
}

###### Listeners ####
resource "aws_lb_listener" "alb_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_port_https
  protocol          = var.alb_proto_https
  ssl_policy        = var.alb_ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
    # type = "fixed-response"
    # fixed_response {
    #   content_type = "text/plain"
    #   message_body = "Page not found. Com back later"
    #   status_code  = "200"
    # }
  }
}

resource "aws_lb_listener" "alb_http_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_port_http
  protocol          = var.alb_proto_http

  default_action {
    type = "redirect"

    redirect {
      port        = var.alb_port_https
      protocol    = var.alb_proto_https
      status_code = "HTTP_301"
    }
  }
}

#### Listener rule ####
resource "aws_lb_listener_rule" "alb_web_rule" {
  listener_arn = aws_lb_listener.alb_https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  condition {
    path_pattern {
      values = ["jcz-realestate.com", "www.staging.jcz-realestate.com"]
    }
  }
}

####### DNS Record #####
resource "aws_route53_record" "staging" {
  for_each = var.dns_alias
  zone_id  = var.zone_id
  name     = each.value
  type     = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
