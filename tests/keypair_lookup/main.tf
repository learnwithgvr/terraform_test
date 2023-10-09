terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region_name
}

variable "region_name" {
  type = string
}

variable "keypair_name" {
  type = string
}

data "aws_key_pair" "this" {
  key_name = "dev-key"
}
