# resource "aws_vpc" "main" {
#   count                = var.vpc_count
#   cidr_block           = var.cidr_block
#   enable_dns_hostnames = var.enable_dns
# }

###  create users using loops ##
resource "aws_iam_user" "name" {
  count = length(var.infrasec_users)
  name  = var.infrasec_users[count.index]
}

output "user_arn" {
  value = aws_iam_user.name[*].arn
}
##### Foreach loop for managers
resource "aws_iam_user" "managers" {
  for_each = toset(var.infrasec_managers)
  name     = each.value
}
