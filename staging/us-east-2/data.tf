data "aws_route53_zone" "jcz-realestate" {
  name = "jcz-realestate.com."
}

########## Web Base AMI #############

data "aws_ami" "example" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["test-web-*"]
  }
}

### ACM Certificate for listeners ####

data "aws_acm_certificate" "alb_cert" {
  domain      = "jcz-realestate.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
