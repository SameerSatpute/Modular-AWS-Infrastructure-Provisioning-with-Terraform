terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.71.0"
    }
  }
  backend "s3" {
  bucket = "statelockfilebucketfordevinfra"
  key = "terraform.tfstate"
  region = "ap-south-1"
  use_lockfile = true
  }
}

provider "aws" {
  region = "ap-south-1"
}

