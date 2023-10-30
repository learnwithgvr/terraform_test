#6 sixth
run "ec2_ami_check" {
  command = plan

  assert {
    condition = module.ec2.ami_id == "ami-0c85e22f0829284aa"
    error_message = "TEST_ERROR: AMI is wrongh"
  }
}