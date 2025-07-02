module "vpc" {
  source = "./modules/vpc"
  name = "marong-vpc"
  cidr_block = "10.0.0.0/16"
}

module "alb" {
  source = "./modules/lb/alb"
  security_group_id = module.securitygroup.marong-alb-sg_id
  subnet_ids = module.vpc.public_subnet
  vpc_id = module.vpc.vpc_id
  target_instance_ids = module.worker.worker-instance-ids
}

module "nlb" {
  source = "./modules/lb/nlb"
  security_group_id = module.securitygroup.marong-alb-sg_id
  subnet_ids = module.vpc.public_subnet
  vpc_id = module.vpc.vpc_id
  target_instance_ids = module.master.master-instance-ids
}

module "bastion" {
  source = "./modules/ec2/bastion-ec2"
  ami_id = "ami-08943a151bd468f4e"
  instance_type = "t3.medium"
  subnet_id = module.vpc.public_subnet[0]
  security_group_ids = [module.securitygroup.marong-bastion-sg_id]
  key_name = var.key_name
  region = "ap-northeast-2"
}

module "master" {
  source = "./modules/ec2/master-ec2"
  master_count = 1
  ami_id = "ami-08943a151bd468f4e"
  instance_type = "t3.medium"
  subnet_id = module.vpc.private_subnet[0]
  security_group_ids = [module.securitygroup.marong-master-sg_id]
  key_name = var.key_name
}

module "worker" {
  source = "./modules/ec2/worker-ec2"
  worker_count = 2
  ami_id = "ami-08943a151bd468f4e"
  instance_type = "t3.medium"
  subnet_ids = module.vpc.private_subnet
  security_group_ids = [module.securitygroup.marong-worker-sg_id]
  key_name = var.key_name
}

module "ecr" {
  source = "./modules/ecr"
}

module "securitygroup" {
  source = "./modules/securitygroup"
  vpc_id = module.vpc.vpc_id
}