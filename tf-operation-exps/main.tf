terraform {}

#number list
variable "number_list" {
    type = list(number)
    default = [ 1,2,3,4,5 ]
}

#Object list of person
variable "person_list" {
    type = list(object({
      fname = string
      lname = string
    }))
    default = [ {
      fname = "Akshay"
      lname = "Dhok"
    }, {
        fname = "Raj"
        lname = "Kumar"
    } ]
}

#map list
variable "map_list" {
    type = map(number)
    default = {
      "one" = 1
      "two" = 2
      "three" = 3
    }
}


#calcilation
locals {
  mul = 2 * 4
  add = 2 + 6
  eq  = 2 !=3

  #double the list
  double = [for num in var.number_list : num * 2]
  odd = [for num in var.number_list: num if num%2 !=0]

  #person list
  fname = [for per in var.person_list: per.lname]

  #work with map
  map_info = [for key, value in var.map_list: value * 5 ]

  double_map = {for key, value in var.map_list: key => value*2}
  
}

output "output" {
  value = local.double_map
}