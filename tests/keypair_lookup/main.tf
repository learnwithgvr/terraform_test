variable "keypair_name" {
  type = string
}

data "aws_key_pair" "this" {
  key_name = "dev-key"
}
