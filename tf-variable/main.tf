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
  owner = "Akshay"
  name = "Myserver"
}

resource "aws_instance" "myweb" {
    ami = "ami-0cc38fb663faa09c2"
    instance_type = var.aws_instance_type
    root_block_device {
      delete_on_termination = true
      volume_size = var.ec2_config.v_size
      volume_type = var.ec2_config.v_type
    }
    tags = merge(var.additional_tags,{
        Name = local.name
    })
}