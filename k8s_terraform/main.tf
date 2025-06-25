module "vpc" {
  source = "./modules/vpc"
  name = "marong-vpc"
  cidr_block = "10.0.0.0/16"
}