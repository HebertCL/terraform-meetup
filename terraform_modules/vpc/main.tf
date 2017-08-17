#----------------------------------
# Terraform modules usage example
#----------------------------------

# Configure a remote state for vpc resources needed.
terraform {
  backend "local" {
    path = "../remote_state/vpc/terraform.tfstate"
  }
}

# Create a new VPC.
resource "aws_vpc" "module_example_vpc" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = "true"

  tags {
    Name = "Module example VPC"
  }
}

# Create a new gateway.
resource "aws_internet_gateway" "module_example_gw" {
  vpc_id = "${aws_vpc.module_example_vpc.id}"

  tags {
    Name = "Module example GW"
  }
}

# Create a new public subnet.
resource "aws_subnet" "module_example_subnet" {
  vpc_id = "${aws_vpc.module_example_vpc.id}" // Using interpolation syntax.
  cidr_block = "${var.subnet_cidr}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "Module example subnet"
  }
}

# Create a new public table.
resource "aws_route_table" "module_example_rt" {
  vpc_id = "${aws_vpc.module_example_vpc.id}" // Using interpolation syntax.
  route{
          cidr_block = "0.0.0.0/0"
          gateway_id = "${aws_internet_gateway.module_example_gw.id}"
  }
  tags {
    Name = "Module example routing table"
  }
}

# Associate route table with the subnet.

resource "aws_route_table_association" "module_example" {
    subnet_id = "${aws_subnet.module_example_subnet.id}"
    route_table_id = "${aws_route_table.module_example_rt.id}"
}
