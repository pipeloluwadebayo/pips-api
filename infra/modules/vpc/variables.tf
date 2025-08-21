variable "name" { 
    type = string 
    description = "The name of the VPC"
    }

variable "cidr" { 
    type = string
    description = "The CIDR block for the VPC"
    default = "10.0.0.0/16"
    }