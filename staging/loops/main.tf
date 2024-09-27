resource "aws_vpc" "main" {
  count      = var.vpc_count
  cidr_block = var.cidr_block

}
