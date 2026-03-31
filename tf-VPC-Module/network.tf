provider "aws" {
    region = "eu-north-1"
}
module "vpc" {
source  = "terraform-aws-modules/vpc/aws"
version = "6.6.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"
  azs = ["eu-north-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


