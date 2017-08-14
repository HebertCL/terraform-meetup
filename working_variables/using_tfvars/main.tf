#----------------------------------------------------
#  Terraform defined variables example using tfvars
#----------------------------------------------------

# Defining AWS provider.
provider "aws" {
   region = "${var.region}"
}

# Let's create yet another instance.
resource "aws_instance" "example3_instance" {
  ami = "${var.example3_ami}"
  instance_type = "${var.instance_size}"
  count = "${var.instance_number}"

  tags {
    Name = "Example 3 instance"
  }
}
