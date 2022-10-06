module "network" {
  source      = "github.com/edmarinho/terraform-network?ref=1.0.0"
  owner       = local.owner
  environment = local.env
  region      = lookup(var.aws_region, local.env)
}

module "frontend" {
  source      = "github.com/edmarinho/terraform-frontend?ref=1.0.0"
  region      = lookup(var.aws_region, local.env)
  aws_vpc     = module.network.vpc.id
  subnet_ids  = module.network.subnet_public_id
  owner       = local.owner
  environment = local.env
  product     = local.product
  service     = local.service
}

module "backend" {
  source      = "github.com/edmarinho/terraform-backend?ref=1.0.0"
  aws_vpc     = module.network.vpc.id
  subnet_ids  = module.network.subnet_public_id
  owner       = local.owner
  environment = local.env
  product     = local.product
  service     = local.service
}

module "database" {
  source      = "github.com/edmarinho/terraform-database?ref=1.0.0"
  engine      = "postgres"
  storage     = 10
  aws_vpc     = module.network.vpc.id
  subnet_ids  = module.network.subnet_public_id
  owner       = local.owner
  environment = local.env
  product     = local.product
  service     = local.service
  db_username = "foo"
  db_password = "passwordfoo"
}