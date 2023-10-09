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

# Generate a new RSA key pair
resource "tls_private_key" "dev" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Save the private key to a file with .pem extension
resource "local_file" "key" {
  content  = tls_private_key.dev.private_key_pem
  filename = "${path.module}/${var.keypair_name}.pem"
}

# Create a key pair resource in AWS with the public key
resource "aws_key_pair" "dev" {
  key_name   = var.keypair_name
  public_key = tls_private_key.dev.public_key_openssh
}

