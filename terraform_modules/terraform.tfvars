#-------------------------------
# Modules example variables
#-------------------------------

# General
aws_region = "us-east-1"

# VPC
cidr = "10.0.0.0/16"
subnet_cidr = "10.0.0.0/24"

# Instance
ami_id = "ami-4fffc834"
size = "t2.micro"
logging_key = "hacl"

# Autoscaling
image_id = "ami-4fffc834"
inst_size = "t2.micro"
ssh_key = "hacl"
ssh_port = 22
http_port = 8080
min_size = 2
max_size = 4
