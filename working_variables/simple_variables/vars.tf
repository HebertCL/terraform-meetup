#--------------------------
#     Variables example
#--------------------------

variable "region" {
  default = "us-east-1"
}

variable "sample_ami" {
  default = "ami-22ce4934"
}

variable "inst_size" {
  default = "t2.micro"
}

variable "count" {
  description = "Enter the number of instances to create"
  default = 2
}
