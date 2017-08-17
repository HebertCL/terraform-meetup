#----------------------------------
# Module example instance template
#----------------------------------

# Define a remote state for network values
data "terraform_remote_state" "network" {
       backend = "local"
       config {
               path = "../remote_state/vpc/terraform.tfstate"
       }
}

# Configure instance parameters
resource "aws_instance" "module_instance" {
        ami                             = "${var.ami_id}"
        instance_type                   = "${var.size}"
        key_name                        = "${var.logging_key}"
        security_groups                 = ["${aws_security_group.module_instance_sg.id}"]
        #subnet_id                       = "${data.terraform_remote_state.network.subnet_id}"

        tags {
                type                    = "Name"
                value                   = "Module instance template"
                propagate_at_launch     = true
        }
}

# Configure instance security group
resource "aws_security_group" "module_instance_sg" {
        name            = "instance_security_group"
        description     = " Launch Configuration Security Group"
        #vpc_id          = "${data.terraform_remote_state.network.vpc_id}"

        ingress {
                from_port       = 22
                to_port         = 22
                protocol        = "tcp"
                cidr_blocks     = ["0.0.0.0/0"]
        }
        egress {
                from_port       = 0
                to_port         = 0
                protocol        = "-1"
                cidr_blocks     = ["0.0.0.0/0"]
        }

        lifecycle {
                create_before_destroy = true
        }
}
