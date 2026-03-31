#VPC
output "vpc_id" {
  value = aws_vpc.main.id
}

locals {
  #TO format the subnet IDs which may be multiples in format of subnet name ={id=, az=}
  public_subnet_output = {
    for key, config in local.public_subnet: key => {
    subnet_id = aws_subnet.main[key].id
    az = aws_subnet.main[key].availability_zone
    }
  }
  private_subnet_output = {
    for key, config in local.private_subnet: key => {
    subnet_id = aws_subnet.main[key].id
    az = aws_subnet.main[key].availability_zone
    }
  }
}

#subnet details
output "public_sub" {
  value = local.public_subnet_output
}

output "private_sub" {
  value =local.private_subnet_output
}