resource "aws_instance" "myweb" {
    ami = "ami-0cc38fb663faa09c2"
    instance_type = "t3.micro"
    
    subnet_id = data.aws_subnet.private_sub.id
    security_groups = [ data.aws_security_group.my-sg.id ]
    associate_public_ip_address = "true"
    tags = {
      Name = "myweb"
    }
}