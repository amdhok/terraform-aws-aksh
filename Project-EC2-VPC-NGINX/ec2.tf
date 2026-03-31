resource "aws_instance" "myserver" {
    ami = "ami-0cc38fb663faa09c2"
    instance_type = "t3.small"
    subnet_id = aws_subnet.public.id
    associate_public_ip_address = "true"
    vpc_security_group_ids = [ aws_security_group.nginx-sg.id ]
    user_data = <<-EOF
                 #!/bin/bash
                 sudo yum install nginx -y
                 sudo systemctl start nginx
                 EOF

    tags = {
        Name = "myserver"
    }
  
}