variable "key_name" {
    description = "In this admin will provide the name for key"
    type = string
}

variable "public_key" {
  description = "Path to the public key file"
  type        = string
}

variable "ec2" {
    description = "Map of EC2 instances to create"
    type = map(object({
        ami                = string
        instance_type      = string
        subnet_id          = string
        public_ip          = bool
        security_group_ids = list(string)
        volume_size        = number
        volume_type        = string
        instance_profile   = optional(string)
    }))
}


