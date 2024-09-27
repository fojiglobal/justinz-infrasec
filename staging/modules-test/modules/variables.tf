# variable "cidr_block" {
#   type = string
# }

variable "enable_dns" {
  type    = bool
  default = false

}

#### Map of objects to create subnets using foreach loops
variable "public_subnets" {
  type = map(object({
    cidr             = string
    azs              = string
    enable_public_ip = bool
    tags             = map(string)
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    azs  = string
    tags = map(string)
  }))
}

variable "env" {
  type = string
}

variable "vpc_cidr" {
  type = string
}
