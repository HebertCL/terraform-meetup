#---------------------------------------
#  Terraform defined variables example
#---------------------------------------

# Defining AWS provider.
provider "aws" {
   region = "${var.region}"
}

# Let's create another instance.
resource "aws_instance" "example2_instance" {
  ami = "${var.example2_ami}"
  instance_type = "${var.instance_size}"

  tags {
    Name = "Example 2 instance"
  }
}
