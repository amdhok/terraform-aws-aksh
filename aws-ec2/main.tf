terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {
    ami = "ami-080254318c2d8932f"
    instance_type = "t3.small"

    tags = {
        Name = "Sampleserver"
    }
  
}

