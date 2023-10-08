module "ec2" {
  source        = "./modules/ec2"
  instance_name = var.instance_name
  instance_type = var.instance_type

  providers = {
    aws = aws
  }
}

output "ec2_output" {
  value = module.ec2
}

output "ec2_created_for" {
  value = "DEMO"
}
