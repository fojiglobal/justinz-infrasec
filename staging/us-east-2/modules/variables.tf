variable "vpc_cidr" {
  type = string
}

variable "env" {
  type = string
}

#####Subnets Variables ####

variable "public_subnets" {
  type = map(object({
    cidr = string
    azs  = string
    tags = map(string)
  }))
}

variable "map_public_ip" {
  type    = bool
  default = true
}

variable "private_subnets" {
  type = map(object({
    cidr = string
    azs  = string
    tags = map(string)
  }))
}
