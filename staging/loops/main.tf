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

# output "name" {
#   value = aws_iam_user.name[2]
# }

output "user1" {
  value = aws_iam_user.name[0].arn
}
output "user2" {
  value = aws_iam_user.name[1].arn
}
output "user3" {
  value = aws_iam_user.name[2].arn
}
