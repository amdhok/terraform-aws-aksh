provider "aws" {
    region = "eu-north-1"
  
}

module "ec2-instance" {
source  = "terraform-aws-modules/ec2-instance/aws"
version = "6.4.0"

for_each = toset(["one", "two"])

  name = "instance-${each.key}"

  instance_type = "t3.micro"
  ami           = "ami-0cc38fb663faa09c2"
  subnet_id     = "subnet-09e2e7902d9350478"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

