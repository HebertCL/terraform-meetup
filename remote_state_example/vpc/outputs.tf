#------------------------------
#   Remote example outputs
#------------------------------

output "vpc_id" {
  value = "${aws_vpc.remote_example_vpc.id}"
}

output "subnet_id" {
  value = "${aws_subnet.remote_example_subnet.id}"
}
