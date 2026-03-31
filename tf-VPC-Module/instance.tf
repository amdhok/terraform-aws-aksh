module "ec2-instance" {
source  = "terraform-aws-modules/ec2-instance/aws"
version = "6.4.0"
name = "single-instance"

  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnets[0]
  ami = "ami-0cc38fb663faa09c2"

  tags = {
    Name = "Module-Project"
    Environment = "dev"
  }
}
