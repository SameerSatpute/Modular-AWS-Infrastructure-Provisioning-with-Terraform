variable "cidr_block" { 
    description = "In this admin will provide the cide block for the vpc"
    type = string
}

variable "instance_tenancy" {
    description = "In this admin will provide the instance tenancy"
    type = string
}

variable "region" {
    description = "In this the admin will provide the region"
    type = string
}

################################################################################################################
variable "subnet_name" {
    description = "In this admin will provide the subnet name"
    type = string
}

variable "availability_zone" {
    description = "In this admin will provide the availability_zone"
    type = string
}

variable "subnet1cidr_block" {
    description = "In this admin will provide the cidr block for the subnet"
    type = string
}

variable "subnet1publicip" {
    description = "In this admin will decide wheather to give public ipv4 address to the subnet or not"
    type = bool
}

variable "availability_zone2" {
    description = "In this admin will provide the az for subnet 2"
    type = string
}

variable "subnet2cidr_block" {
    description = "In this admin will provide the cidr block for the subnet"
    type = string
}

variable "subnet_name2" {
    description = "In this admin will provide the subnet name"
    type = string
}

variable "routetablecidr" {
    description = "In this the admin will provide the cidr for the route table"
    type = string
}

variable "service_name" {
    description = "In this admin will provide the service name"
    type = string
}

variable "type" {
    description = "In this admin will provide the type"
    type = string
}


