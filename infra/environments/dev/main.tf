
locals {
  project_name = "eg-devsecops"
  environment  = "dev"
  aws_region   = "us-east-1"
}

# --------------------------------------------------
# 1. NETWORKING
# --------------------------------------------------

module "networking" {
  source = "../../modules/networking"

  name        = local.project_name
  environment = local.environment
  vpc_cidr    = "10.0.0.0/16"
}

# --------------------------------------------------
# 2. SECURITY GROUPS
# --------------------------------------------------

module "security" {
  source = "../../modules/security"

  name           = local.project_name
  environment    = local.environment
  vpc_id         = module.networking.vpc_id
  container_port = 3000
}

# --------------------------------------------------
# 3. AMAZON ECR
# --------------------------------------------------

module "ecr" {
  source = "../../modules/ecr"

  repository_name = "enterprise-grade-devsecops-app"
  environment     = local.environment
}

# --------------------------------------------------
# 4. APPLICATION LOAD BALANCER
# --------------------------------------------------

module "alb" {
  source = "../../modules/alb"

  name               = local.project_name
  environment        = local.environment
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  security_group_ids = [module.security.alb_security_group_id]
  container_port     = 3000
}


module "ecs" {
  source = "../../modules/ecs"

  name           = local.project_name
  environment    = local.environment
  aws_region     = local.aws_region
  image_uri      = "${module.ecr.repository_url}:1.0.0"
  container_name = "enterprise-grade-devsecops-app"
  container_port = 3000

  cpu           = 256
  memory        = 512
  desired_count = 1

  private_subnet_ids = module.networking.private_subnet_ids
  security_group_ids = [module.security.ecs_security_group_id]
  target_group_arn   = module.alb.target_group_arn
}
