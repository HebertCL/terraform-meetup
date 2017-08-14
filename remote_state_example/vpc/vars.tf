#-----------------------------
#   Remote example variables
#-----------------------------

variable "aws_region" {
  default = "us-east-1"
}
variable "access_key" {}
variable "secret_key" {}
variable "cidr" {
  default = "10.0.0.0/16"
}
variable "subnet_cidr" {
  default = "10.0.0.0/24"
}
variable "a_zone" {
  default = "us-east-1a"
}
variable "route_cidr" {
  default = "0.0.0.0/0"
}
