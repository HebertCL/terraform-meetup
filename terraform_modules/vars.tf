#--------------------------------------
# Module example variable definition
#--------------------------------------

# General
variable "aws_region" {}

# VPC
variable "cidr" {}
variable "subnet_cidr" {}

# Instance
variable "ami_id" {}
variable "size" {}
variable "logging_key" {}

# Autoscaling
variable "image_id" {}
variable "inst_size" {}
variable "ssh_key" {}
variable "ssh_port" {}
variable "http_port" {}
variable "min_size" {}
variable "max_size" {}
