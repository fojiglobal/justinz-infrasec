#### Locals for VPC ####

locals {
  vpc_cidr = "10.50.0.0/16"
  env      = "staging"
}

####### Public Subnets Locals ####
locals {
  public_subnets = {
    "pub-sub-1" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 1)
      azs  = "us-east-2a"
      tags = {
        Name        = "pub-sub-1"
        Environment = local.env
      }
    }
    "pub-sub-2" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 2)
      azs  = "us-east-2b"
      tags = {
        Name        = "pub-sub-2"
        Environment = local.env
      }
    }
    "pub-sub-3" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 3)
      azs  = "us-east-2c"
      tags = {
        Name        = "pub-sub-3"
        Environment = local.env
      }
    }
  }
}


####### Private subnets Locals ####
locals {
  private_subnets = {
    "priv-sub-1" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 10)
      azs  = "us-east-2a"
      tags = {
        Name        = "priv-sub-1"
        Environment = local.env
      }
    }
    "priv-sub-2" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 11)
      azs  = "us-east-2b"
      tags = {
        Name        = "priv-sub-2"
        Environment = local.env
      }
    }
    "priv-sub-3" = {
      cidr = cidrsubnet(local.vpc_cidr, 8, 12)
      azs  = "us-east-2c"
      tags = {
        Name        = "priv-sub-3"
        Environment = local.env
      }
    }
  }
}
