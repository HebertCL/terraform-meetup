#--------------------------
# Remote example webserver
#--------------------------

# Define AWS provider.
provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

# Import VPC script output.
data "terraform_remote_state" "vpc" {
  backend = "local"
  config {
      #path = "../remote_state/vpc/terraform.tfstate" // Relative path in Linux/OS X.
      path = "..\remote_state\vpc\terraform.tfstate" // Relative path in Windows.
  }
}

# Create Auto Scaling Group launch configuration.
resource "aws_launch_configuration" "webserver" {
        image_id = "${var.ami_id}"
        instance_type = "${var.size}"
        security_groups = ["${aws_security_group.web.id}"]
        key_name = "${var.ssh_key}"
	user_data = "${file("install_apache.sh")}"

        lifecycle {
                create_before_destroy = true
        }
}

# Create Launch Configuration Security Group.
resource "aws_security_group" "web" {
        name = "webserver_security_group"
        description = "Launch Configuration Security Group"
        vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

        ingress {
                from_port = "${var.ssh_port}"
                to_port = "${var.ssh_port}"
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
                from_port = "${var.http_port}"
                to_port = "${var.http_port}"
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }

        lifecycle {
                create_before_destroy = true
        }
}

# Create load balancer for webserver group.
resource "aws_elb" "example_elb" {
        name = "remote-example-elb"
        security_groups = ["${aws_security_group.lb.id}"]
	subnets = ["${data.terraform_remote_state.vpc.subnet_id}"]

        health_check {
                healthy_threshold = 2
                unhealthy_threshold = 2
                timeout = 10
                interval = 30
                target = "TCP:22"
        }
        listener {
                lb_port = "${var.http_port}"
                lb_protocol = "http"
                instance_port = "${var.http_port}"
                instance_protocol = "http"
        }
	tags {
                Name = "Webserver Load Balancer"
        }
}

# Create load balancer security Group
resource "aws_security_group" "lb" {
        name = "example-lbsg"
        description = "Allow Port 80 Incoming Traffic"
        vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

        ingress {
                from_port = "${var.http_port}"
                to_port = "${var.http_port}"
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        egress {
                from_port = 0
                to_port = 0
                protocol = -1
                cidr_blocks = ["0.0.0.0/0"]
        }
}

# Create auto scaling group.
resource "aws_autoscaling_group" "example_web_asg" {
        vpc_zone_identifier = ["${data.terraform_remote_state.vpc.subnet_id}"]
        name = "web_asg"
        min_size = "${var.min_size}"
        max_size = "${var.max_size}"
	health_check_grace_period = 100
	health_check_type = "ELB"
	load_balancers = ["${aws_elb.test_lb.id}"]
        launch_configuration = "${aws_launch_configuration.webserver.id}"
        force_delete = true

        lifecycle {
                create_before_destroy = true
        }
}
