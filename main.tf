provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.repository_name
}

module "ecs" {
  source              = "./modules/ecs"
  cluster_name        = var.cluster_name
  task_execution_role = module.ecr.execution_role_arn
  subnet_ids          = [module.vpc.public_subnet_id]
  security_group_id   = module.vpc.ecs_security_group_id
  ecr_repository_uri   = module.ecr.repository_uri
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "ecr_repository_uri" {
  value = module.ecr.repository_uri
}
