variable "aws_region" {
  description = "AWS region to create instances in."
  default     = "us-west-2"
}

variable "inst_count" {
  description = "Enter number of instances you want to create"
  default     = 2
}

variable "ami_name" {
  description = "Enter the name of the ami you want to create an instance from"
  default     = "ami-02d0ea44ae3fe9561"
}

variable "ebs_names" {
  default = [
    "/dev/sdd",
#    "/dev/sde",
#    "/dev/sdf",
  ]
}