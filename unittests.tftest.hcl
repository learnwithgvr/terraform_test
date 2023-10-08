variables {
  global_var_org = "GVR"
  global_cc = "123"
  global_bu = "IT"
} 

#1 input validation
run "validate_inputs" {
  command = plan

  variables {
    instance_name = "devinstance99"
    instance_type = "t2micro"
    region_name   = "ap-southeast-1"
  } 

  expect_failures = [
    var.instance_name,
    var.instance_type
  ]
}

#2 unit testing
run "name_validation"{
  command = plan

  assert {
    condition = module.ec2.ec2_instance_tags["Name"] == "${var.instance_name}-${var.region_name}"
    error_message = "TEST_ERROR: Instance name is not as expected"
  }
}

run "org_validation"{
  command = plan

  // variables{
  //   local_var_org = "ABC"
  // }

  assert {
    condition = module.ec2.ec2_instance_tags["Organization"] == var.global_var_org
    error_message = "TEST_ERROR: Instance Organization is not as expected"
  }
}

run "cc_validation"{
  command = plan

  // variables{
  //   local_var_org = "ABC"
  // }

  assert {
    condition = module.ec2.ec2_instance_tags["Cost_Centre"] == var.global_cc
    error_message = "TEST_ERROR: Cost_Centre is not as expected"
  }
}

run "bu_validation"{
  command = plan

  // variables{
  //   local_var_org = "ABC"
  // }

  assert {
    condition = module.ec2.ec2_instance_tags["Business_Unit"] == var.global_bu
    error_message = "TEST_ERROR: Cost_Centre is not as expected"
  }
}

#2 customized provider 1
provider "aws" {
  alias  = "america"
  region = "us-east-1"
}

run "customised_provider_america" {

  command = plan

  providers = {
    aws = aws.america
  }

  assert {
    condition = module.ec2.ec2_instance_tags["Name"] == "${var.instance_name}-us-east-1"
    error_message = "TEST_ERROR: Instance name is not as expected"
  }
}

#3 customized provider 2
provider "aws" {
  alias  = "london"
  region = "eu-west-2"
}

run "customised_provider_london" {

  command = plan

  providers = {
    aws = aws.london
  }

  assert {
    condition = module.ec2.ec2_instance_tags["Name"] == "${var.instance_name}-eu-west-2"
    error_message = "TEST_ERROR: Instance name is not as expected"
  }
}

#4 modules - Integaration testing 
run "create_key_pair" {
  # Create the ec2 key pair .

  module {
    source = "./tests/keypair_create"
  }
}

run "lookup_verify_key_pair" {
  # Verify created ec2 key pair.

  module {
    source = "./tests/keypair_lookup"
  }

  assert {
    condition     = data.aws_key_pair.this.key_name == var.keypair_name
    error_message = "Key pair name is wrong"
  }
}

#5 passing values between run blocks
run "check_name_validation_call" {
  assert {
    condition = run.name_validation.ec2_created_for== "DEMO"
    error_message = "TEST_ERROR: Created for is wrong"
  }
}