locals {
  vpc_cidr = "10.120.0.0/16"
  env      = "dev"
  public_subnets = {
    "pub-sub1" = {
      cidr             = "10.120.1.0/24"
      azs              = "us-east-2a"
      enable_public_ip = true
      tags = {
        Name        = "pub-sub1"
        Environment = "dev"
      }
    }

    "pub-sub2" = {
      cidr             = "10.120.2.0/24"
      azs              = "us-east-2b"
      enable_public_ip = true
      tags = {
        Name        = "pub-sub2"
        Environment = "dev"
      }
    }

    "pub-sub3" = {
      cidr             = "10.120.3.0/24"
      azs              = "us-east-2c"
      enable_public_ip = true
      tags = {
        Name        = "pub-sub3"
        Environment = "dev"
      }
    }

  }

  private_subnets = {
    "priv-sub1" = {
      cidr = "10.120.10.0/24"
      azs  = "us-east-2a"
      tags = {
        Name        = "priv-sub1"
        Environment = "dev"
      }
    }

    "priv-sub2" = {
      cidr = "10.120.11.0/24"
      azs  = "us-east-2b"
      tags = {
        Name        = "priv-sub2"
        Environment = "dev"
      }
    }

    "priv-sub3" = {
      cidr = "10.120.12.0/24"
      azs  = "us-east-2c"
      tags = {
        Name        = "priv-sub3"
        Environment = "dev"
      }
    }

  }

}

module "dev" {
  source = "./modules"
  #cidr_block      = local.vpc_cidr
  vpc_cidr        = local.vpc_cidr
  env             = local.env
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
}

