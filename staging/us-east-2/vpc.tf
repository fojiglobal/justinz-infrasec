module "staging" {
  source          = "./modules"
  vpc_cidr        = local.vpc_cidr
  env             = local.env
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
}

output "vpc_id" {
  value = module.staging.vpc_id
}
