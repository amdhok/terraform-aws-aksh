variable "vpc_config" {
    description = "To get the cidr and name of vpc from user"
    type = object({
      cidr_block = string
      name = string
    })
    validation {
      condition = can(cidrnetmask(var.vpc_config.cidr_block))
      error_message = "Invalid CIDR Format - ${var.vpc_config.cidr_block}"
    }
}

variable "sub_config" {
  description = "To get the cidr and AZ for sub from user"
  type = map(object({
    cidr_block = string
    az = string 
    public = optional(bool, false)
  }))

  validation {
      condition = alltrue([for config in var.sub_config: can(cidrnetmask(config.cidr_block))])
      error_message = "Invalid CIDR Format"
}
}