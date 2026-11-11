variable "bucketname" {
    description = "In this admin will provide the bucket name"
    type = string
}

variable "bucket_namespace" {
    description = "In this user will get give the namespace"
    type = string
}

variable "object_ownership" {
    description = "In this admin will provide the bucket ownership"
    type = string
}

variable "versioning" {
    description = "In this admin will set the versioning of the bucket"
    type = string
}

variable "prefix" {
    description = "In this admin will provide the object"
    type = string
}

variable "day" {
    description = "In this admin will provide the day"
    type = number
}

variable "storage_class" {
    description = "In this admin will provide the storage class and days"
    type = string
}

variable "days" {
    description = "In this amdin will provide the days to delete the data"
    type = number
}

variable "noncurrent_days" {
    description = "In this admin will configure the days to delete the data"
    type = number
}