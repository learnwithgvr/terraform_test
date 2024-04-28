data "aws_caller_identity" "current" {}

#ami 
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"
    # values = ["al2023-ami-2023.*.*.0-kernel-*-x86_64"] 

    # Amazon Linux 2 AMI
    values = ["amzn2-ami-kernel-*.*-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"] # Filter by Amazon as the owner
}

#vpc 
data "aws_vpc" "my_vpc" {
  filter {
    name   = "owner-id"
    values = ["${data.aws_caller_identity.current.account_id}"]
  }
}

#subnets
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.my_vpc.id]
  }
}

data "aws_region" "this" {
  provider = aws
}


# ec2 
resource "aws_instance" "dev_test" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = element(data.aws_subnets.subnets.ids, 0)

  tags = {
    Name          = "${var.instance_name}-${data.aws_region.this.name}"
    Organization  = "GVR"
    Cost_Centre   = "123"
    Business_Unit = "IT"
  }
}
