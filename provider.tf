terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      configuration_aliases = [aws]
    }
  }
}
#--------------------
provider "aws" {
  region = var.region_name
}
