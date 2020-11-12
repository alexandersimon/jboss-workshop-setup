variable "aws_region" {
  description = "AWS region to create the instances in"
  default     = "eu-central-1"
}

variable "aws_az" {
  description = "AWS availability zone to create the instances in"
  default     = "eu-central-1b"
}

variable "ami_id_centos7" {
  description = "CentOS 7 AMI id"
  default     = "ami-0e8286b71b81c3cc1"
}

variable "vpc_id" {
  default = "vpc-95679afc"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "instance_names" {
  description = "list of instances to spin up"
  type        = list(string)
  default     = [
    "cicd",
    "lb",
    "jboss-0",
    "jboss-1",
    "mon"
  ]
}

variable "ingress_ports" {
  description = "list of open ingress ports"
  type        = list(number)
  default     = [
    22,
    8080,
    8443,
    9990,
    9993,
    80,
    9092,
    2181,
    2888,
    3888
  ]
}