#------------------------------
#   Remote state usage example
#------------------------------

# Define AWS provider.
provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

# Configure a remote state for vpc resources needed.
terraform {
  backend "local" {
    path = "../remote_state/vpc/terraform.tfstate" // Remote state configuration for Linux/OS X.
    #path = "..\remote_state\vpc\terraform.tfstate" // Remote state configuration for Windows.
  }
}

# Create a new VPC.
resource "aws_vpc" "remote_example_vpc" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = "true"

  tags {
    Name = "Remote example VPC"
  }
}

# Create a new gateway.
resource "aws_internet_gateway" "remote_example_gw" {
  vpc_id = "${aws_vpc.remote_example_vpc.id}"

  tags {
    Name = "Remote example GW"
  }
}

# Create a new public subnet.
resource "aws_subnet" "remote_example_subnet" {
  vpc_id = "${aws_vpc.remote_example_vpc.id}" // Using interpolation syntax.
  cidr_block = "${var.subnet_cidr}"
  map_public_ip_on_launch = "true"
  availability_zone = "${var.a_zone}"

  tags {
    Name = "Remote example subnet"
  }
}

# Create a new public table.
resource "aws_route_table" "remote_example_rt" {
  vpc_id = "${aws_vpc.remote_example_vpc.id}" // Using interpolation syntax.
  route{
          cidr_block = "0.0.0.0/0"
          gateway_id = "${aws_internet_gateway.remote_example_gw.id}"
  }
  tags {
    Name = "Remote example routing table"
  }
}

# Associate route table with the subnet.

resource "aws_route_table_association" "remote_example" {
    subnet_id = "${aws_subnet.remote_example_subnet.id}"
    route_table_id = "${aws_route_table.remote_example_rt.id}"
}
