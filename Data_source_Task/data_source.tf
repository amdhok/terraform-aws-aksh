#Security group
data "aws_security_group" "my-sg" {
    tags = {
      Name = "mysg"
    }
}
  

#VPC
data "aws_vpc" "vpc" {
    tags = {
      ENV = "tf"
      Name = "my-vpc-1"
    }
}

#private subnet
data "aws_subnet" "private_sub" {
    tags = {
      Name = "private-sub"
    } 
}