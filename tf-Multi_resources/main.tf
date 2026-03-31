terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
  }
}

provider "aws" {
    region = "eu-north-1"
}

locals {
  project = "Projetc-01"
}

resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${local.project}-vpc"
    }
}

resource "aws_subnet" "sub" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.${count.index}.0/24"
    count = 2
    tags = {
      Name = "${local.project}-subnet-${count.index}"
    }
}

#create 4ec2
resource "aws_instance" "ec2" {
    for_each = var.ec2_map
    ami = each.value.ami
    instance_type = each.value.instance_type
    subnet_id = element(aws_subnet.sub[*].id, index(keys(var.ec2_map), each.key) % length(aws_subnet.sub))
   
  tags = {
    Name = "${local.project}-instance-${each.key}"
  }
}

output "aws_subnet_id" {
    value = aws_subnet.sub[0].id
}