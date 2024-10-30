module "vpc" {
    source = "../../modules/vpc"

    vpc_cidr = var.vpc_cidr
    public_subnet_cidr = var.public_subnet_cidr
    private_subnet_cidr = var.private_subnet_cidr
}
# Security Groups Module
module "security_groups" {
  source           = "../../modules/security_groups"
  vpc_id           = module.vpc.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
}

# ECR Module (Free tier storage up to 500MB)
module "ecr" {
  source = "../../modules/ecr"
}

# EC2 Module
module "ec2" {
  source            = "../../modules/ec2"
  public_subnet_id  = module.vpc.public_subnet_id
  security_group_id = module.security_groups.ec2_sg_id
  public_key = var.public_key
}

# RDS Module
module "rds" {
  source               = "../../modules/rds"
  private_subnet_id    = module.vpc.private_subnet_id
  security_group_id    = module.security_groups.rds_sg_id
  db_username          = var.db_username
  db_password          = var.db_password
  db_instance_class    = "db.t3.micro"  # Cost-effective instance type for RDS
  db_engine            = var.db_engine
  db_allocated_storage = 20             # Minimum storage allocation (in GB)
  db_name              = var.db_name
}