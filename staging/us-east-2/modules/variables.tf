variable "vpc_cidr" {
  type = string
}

variable "env" {
  type = string
}

##### Subnets Variables ####

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

variable "pub-sub-name" {
  type = string
}

variable "all_ipv4_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "ami_id" {
  type    = string
  default = "ami-085f9c64a9b75eed5"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_key" {
  type    = string
  default = "cs2-use2-main"
}

variable "user_data" {
  type = string
}

variable "min_size" {
  type    = number
  default = 1
}

variable "max_size" {
  type    = number
  default = 2
}

variable "desired" {
  type    = number
  default = 2
}

variable "public_sg_ingress" {
  type = map(object({
    src         = string
    from_port   = number
    ip_protocol = string
    to_port     = number
    description = string
  }))
}

variable "public_sg_egress" {
  type = map(object({
    dest        = string
    ip_protocol = string
    description = string
  }))
}

variable "private_sg_ingress" {
  type = map(object({
    src         = string
    from_port   = number
    ip_protocol = string
    to_port     = number
    description = string
  }))
}

variable "private_sg_egress" {
  type = map(object({
    dest        = string
    ip_protocol = string
    description = string
  }))
}

variable "bastion_sg_ingress" {
  type = map(object({
    src         = string
    from_port   = number
    to_port     = number
    ip_protocol = string
    description = string
  }))
}

variable "bastion_sg_egress" {
  type = map(object({
    dest        = string
    ip_protocol = string
    description = string
  }))
}
##### Variable for target group ####
variable "alb_port_http" {
  type = number
}

variable "alb_proto_http" {
  type = string
}
##### Application Load Balancer ####
variable "internet_facing" {
  type = string
}

variable "alb_type" {
  type = string
}

variable "alb_proto_https" {
  type = string
}

variable "alb_port_https" {
  type = number
}

variable "alb_ssl_policy" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "dns_alias" {
  type = map(string)
}

variable "zone_id" {
  type = string
}
