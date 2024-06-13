# placing override resources, override data in root
# here underlying provider doesn't matter

override_module {
  target    = module.ec2
  
  outputs = {
    ec2_created_for = "DEMO", 
    ami_id = "ami-02453f5468b897e31"
    ec2_instance_details = ["fsdaf", "t2.micro","aaaa","bbbb"]
    ec2_instance_tags = {
      Business_Unit = "IT"
      Cost_Centre = "123"
      Name = "dev_instance3-ap-southeast-1"
      Organization  = "APPLE"
    }
  }
}

#2 unit testing
run "name_validation" {
  command = plan

  assert {
    condition = module.ec2.ec2_instance_tags["Name"] == "dev_instance3-ap-southeast-1"
    error_message = "TEST_ERROR: Instance name is not as expected"
  }
}