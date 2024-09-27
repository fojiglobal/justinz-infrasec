# resource "aws_vpc" "main" {
#   count                = var.vpc_count
#   cidr_block           = var.cidr_block
#   enable_dns_hostnames = var.enable_dns
# }

###  create users using loops ##
# resource "aws_iam_user" "name" {
#   count = length(var.infrasec_users)
#   name  = var.infrasec_users[count.index]
# }

# output "user_arn" {
#   value = aws_iam_user.name[*].arn
# }
# ##### Foreach loop for managers
# resource "aws_iam_user" "managers" {
#   for_each = toset(var.infrasec_managers)
#   name     = each.value
# }

# resource "aws_vpc" "vpcs" {
#   for_each             = var.vpcs
#   cidr_block           = each.value["cidr"]
#   tags                 = each.value["tags"]
#   enable_dns_hostnames = each.value["enable_dns"]
# }

resource "aws_vpc" "dr" {
  cidr_block = "10.110.0.0/16"
}

resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.dr.id
  for_each                = var.public_subnets
  cidr_block              = each.value["cidr"]
  availability_zone       = each.value["azs"]
  map_public_ip_on_launch = each.value["enable_public_ip"]
  tags                    = each.value["tags"]
}
