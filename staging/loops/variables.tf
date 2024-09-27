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

### Foreach loop to create users
variable "infrasec_managers" {
  type    = list(string)
  default = ["bobama", "jbiden", "kharris"]
}

#### Map of objects to create vpcs using foreach loops
variable "vpcs" {
  type = map(object({
    cidr       = string
    tags       = map(string)
    tenancy    = string
    enable_dns = bool
  }))
  default = {
    "staging" = {
      cidr       = "10.50.0.0/16"
      tenancy    = "default"
      enable_dns = false
      tags = {
        name        = "staging-vpc"
        Environment = "staging"
      }
    }
    "qa" = {
      cidr       = "10.60.0.0/16"
      tenancy    = "default"
      enable_dns = false
      tags = {
        name        = "qa-vpc"
        Environment = "qa"
      }
    }
    "prod" = {
      cidr       = "10.70.0.0/16"
      tenancy    = "default"
      enable_dns = false
      tags = {
        name        = "prod-vpc"
        Environment = "prod"
      }
    }
  }
}


#### Map of objects to create subnets using foreach loops
variable "public_subnets" {
  type = map(object({
    cidr             = string
    azs              = string
    enable_public_ip = bool
    tags             = map(string)
  }))
  default = {
    "pub-sub1" = {
      cidr             = "10.110.1.0/24"
      azs              = "us-east-2a"
      enable_public_ip = true
      tags = {
        name        = "pub-sub1"
        Environment = "staging"
      }
    }

    "pub-sub2" = {
      cidr             = "10.110.2.0/24"
      azs              = "us-east-2a"
      enable_public_ip = true
      tags = {
        name        = "pub-sub2"
        Environment = "staging"
      }
    }
    "pub-sub3" = {
      cidr             = "10.110.3.0/24"
      azs              = "us-east-2a"
      enable_public_ip = true
      tags = {
        name        = "pub-sub3"
        Environment = "staging"
      }
    }
  }
}
