#--------------------------
# Module example outputs
#--------------------------

output "vpc_id" {
  value = "${aws_vpc.module_example_vpc.id}"
}

output "subnet_id" {
  value = "${aws_subnet.module_example_subnet.id}"
}
