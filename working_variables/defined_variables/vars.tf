#------------------------
#  Defined variables
#------------------------

variable "region" {
  description = "Set us-east-1 region"
  default = "us-east-1"
}
variable "example2_ami" {
  description = "Regular CentOS image"
  default = "ami-22ce4934"
}
variable "instance_size" {
  description = "Setting instance size to free tier"
  default = "t2.micro"
}
