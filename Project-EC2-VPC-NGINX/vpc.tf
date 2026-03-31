resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }
}

#Create private subnet
resource "aws_subnet" "private" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "private-sub"
    }
}

#Create public subnet
resource "aws_subnet" "public" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "public-sub"
    }
}

#Create internet gateway
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "my_igw"
    }
}

#create table route
resource "aws_route_table" "my_rt" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
    tags = {
      Name = "my_rt"
    }
}

#route table association
resource "aws_route_table_association" "public_sub" {
    route_table_id = aws_route_table.my_rt.id
    subnet_id = aws_subnet.public.id
}