module "staging" {
  source             = "github.com/fojiglobal/justin-tf-modules//staging?ref=v1.1.0" #"./modules"
  vpc_cidr           = local.vpc_cidr
  env                = local.env
  public_subnets     = local.public_subnets
  private_subnets    = local.private_subnets
  pub-sub-name       = "pub-sub-1"
  user_data          = filebase64("web.sh")
  public_sg_ingress  = local.public_sg_ingress
  public_sg_egress   = local.public_sg_egress
  private_sg_ingress = local.private_sg_ingress
  private_sg_egress  = local.private_sg_egress
  bastion_sg_ingress = local.bastion_sg_ingress
  bastion_sg_egress  = local.bastion_sg_egress
  ami_id             = "ami-036841078a4b68e14"
  alb_port_http      = local.alb_port_http
  alb_proto_http     = local.alb_proto_http
  internet_facing    = local.internet_facing
  alb_type           = local.alb_type
  alb_proto_https    = local.alb_proto_https
  alb_port_https     = local.alb_port_https
  alb_ssl_policy     = local.alb_ssl_policy
  certificate_arn    = local.certificate_arn
  dns_alias          = local.dns_alias
  zone_id            = local.zone_id
}

# output "vpc_id" {
#   value = module.staging.vpc_id
# }

# output "public_subnet_id" {
#   #value = module.staging.public_subnet_ids012.
#   value = module.staging.public_subnet_ids[0]

# }

# output "private_subnet_id" {
#   #value = module.staging.private_subnet_ids012.
#   value = module.staging.private_subnet_ids[0]

