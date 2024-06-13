#6 sixth
run "ec2_ami_check" {
  command = plan

  assert {
    condition = module.ec2.ami_id == "ami-0bcedba63d7253ea7"
    error_message = "TEST_ERROR: AMI is wrongh"
  }
}