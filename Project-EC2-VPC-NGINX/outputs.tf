output "aws_instance_public_ip" {
    description = "Public IP"
    value = aws_instance.myserver.public_ip
}

output "URL_WEB" {
    description = "URL of NGINX"
    value = "http://${aws_instance.myserver.public_ip}"
}