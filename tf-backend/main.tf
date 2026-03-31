terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
  }
  backend "s3" {
    bucket = "my-buck7252"
    key = "backen.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "myserver" {
    ami = "ami-080254318c2d8932f"
    instance_type = "t3.small"

    tags = {
        Name = "Sampleserver"
    }
  
}