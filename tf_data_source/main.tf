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

#Getting ami
data "aws_ami" "name" {
    most_recent = true
    owners = [ "amazon" ]
}

output "ami" {
  value = data.aws_ami.name.id
}

#Getting Existig SG
data "aws_security_groups" "my-sg" {
    tags = {
      Name = "http"
      Security_group_name = "my-sg1"
    }
}

output "my-sg" {
    value = data.aws_security_groups.my-sg
}

#VPC

data "aws_vpc" "vpc" {
    tags = {
      ENV = "tf"
      Name = "my-vpc-1"
    }
}

output "vpc" {
    value = data.aws_vpc.vpc.id
}

data "aws_availability_zones" "names" {
    state = "available"
}

output "AZ" {
    value = data.aws_availability_zones.names
}

data "aws_caller_identity" "caller_id" {
}

output "caller_id" {
    value = data.aws_caller_identity.caller_id
}


resource "aws_instance" "myserver" {
    ami = data.aws_ami.name.id
    instance_type = "t3.small"

    tags = {
        Name = "Sampleserver"
    }
}