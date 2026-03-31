output "my-sg" {
    value = data.aws_security_group.my-sg
}

output "vpc" {
    value = data.aws_vpc.vpc.id
}

output "subnet" {
    value = data.aws_subnet.private_sub.id 
}

output "public_IP" {
    value = aws_instance.myweb.public_ip
}