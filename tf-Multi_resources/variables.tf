variable "ec2_map" {
    #key=value (objetc{ami,instance})
  type = map(object({
         ami = string
         instance_type = string
  }))
}