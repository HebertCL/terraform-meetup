#------------------------------
# Terraform variables example
#------------------------------

# Let us define a provider.
provider "aws" {
  region = "${var.region}"
}

# Now let's create a resource. A single instance will do.
resource "aws_instance" "sample_instance" {
    ami = "${var.sample_ami}"
    instance_type = "${var.inst_size}"
    count = "${var.count}"

    tags {
      Name = "Variable example instance"
    }
}
