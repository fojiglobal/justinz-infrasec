variable "cidr_block" {
  type    = string
  default = "10.50.0.0/16"
}

variable "vpc_count" {
  type    = number
  default = 2
}

variable "enable_dns" {
  type    = bool
  default = false

}

### adding list of string to create users using loops
variable "infrasec_users" {
  type    = list(string)
  default = ["jdoe", "jdone", "jbrown"]
}
