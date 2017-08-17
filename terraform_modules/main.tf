#-------------------------------
# Modules example main script
#-------------------------------

provider "aws" {
  region = "${var.aws_region}"
}

module "network" {
  source = "./vpc/"

  cidr = "${var.cidr}"
  subnet_cidr = "${var.subnet_cidr}"
}

module "instance" {
  source = "./instance/"

  ami_id = "${var.ami_id}"
  size = "${var.size}"
  logging_key = "${var.logging_key}"
}

module "autoscaling" {
  source = "./autoscaling"

  image_id = "${var.image_id}"
  inst_size = "${var.inst_size}"
  ssh_key = "${var.ssh_key}"
  ssh_port = "${var.ssh_port}"
  http_port ="${var.http_port}"
  min_size = "${var.min_size}"
  max_size ="${var.max_size}"
}
