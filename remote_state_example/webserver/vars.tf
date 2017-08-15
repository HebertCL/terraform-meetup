#---------------------------
# Remote example variables
#---------------------------

variable "aws_region" {
  default = "us-east-1"
}
variable "access_key" {}
variable "secret_key" {}
variable "ami_id" {
  default = "ami-22ce4934"
}
variable "size" {
  default = "t2.micro"
}
variable "ssh_key" {
  default = "mykey"
}
variable "ssh_port" {
  default = 22
}
variable "http_port" {
  default = 8080
}
variable "min_size" {
  default = 2
}
variable "max_size" {
  default = 4
}
