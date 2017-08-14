#---------------------------------
#  Defined variables using tfvars
#---------------------------------

variable "region" {
  description = "Set us-east-1 region"
}
variable "example2_ami" {
  description = "Regular CentOS image"
}
variable "instance_size" {
  description = "Setting instance size to free tier"
}
variable "instance_number" {}
