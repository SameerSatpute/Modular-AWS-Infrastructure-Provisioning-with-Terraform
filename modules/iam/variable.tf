variable "policy" {
    description = "In this admin will provide the trusted entity"
    type = string
}

variable "identifier" {
    description = "In this admin will provide the identifier"
    type = list(string)
}

variable "rolename" {
    description = "In this admin will provide the iam role name"
    type = string
}

variable "arn" {
    description = "In this admin should provide the arn of the policy"
    type = string
}

variable "instance_profile" {
    description = "In this admin will provide the name for instance profile"
    type = string
}




