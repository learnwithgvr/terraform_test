variable "instance_name" {
  description = "Name of Ec2Instnace."
  type        = string

  validation {
    # check if the value contains an underscore
    condition     = can(regex("_", var.instance_name))
    error_message = "The name value must have underscore '_' in it."
  }
}

variable "instance_type" {
  description = "Type of Ec2Instnace"
  type        = string

  validation {
    # check if the value contains an underscore
    condition     = can(regex("\\.", var.instance_type))
    error_message = "The name value must have at dot '.' in it."
  }
}

variable "region_name" {
  description = "Region name"
  type        = string
  # default     = "ap-southeast-1"
}
