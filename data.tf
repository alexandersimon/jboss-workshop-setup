data "aws_ami" "ubuntu" {
  owners      = [ "099720109477" ] # Canonical
  most_recent = true

  filter {
    name   = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*" ]
  }

  filter {
    name   = "virtualization-type"
    values = [ "hvm" ]
  }
}

data "aws_ami" "centos7" {
  owners      = [ "057448758665" ]
  most_recent = true

  filter {
    name   = "name"
    values = [ "CentOS 7.7.1908 x86_64 with cloud-init*" ]
  }

  filter {
    name   = "virtualization-type"
    values = [ "hvm" ]
  }
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}
