#####
# creates a new SSH keypair
#####

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh-access" {
  key_name   = "tld-keypair-${terraform.workspace}"
  public_key = tls_private_key.key.public_key_openssh
}


#####
# limit access to machines
#####

resource "aws_security_group" "default-access" {
  name = "default-access-${terraform.workspace}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "cicd" {
  name = "cicd-${terraform.workspace}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "lb" {
  name = "lb-${terraform.workspace}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "jboss" {
  name = "jboss-${terraform.workspace}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}

resource "aws_security_group" "mon" {
  name = "mon-${terraform.workspace}"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}


#####
# spin up all required EC2 instances
#####

resource "aws_instance" "cicd" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.cicd_instance_type
  key_name                    = aws_key_pair.ssh-access.key_name
  associate_public_ip_address = true

  security_groups = [
    aws_security_group.default-access.name,
    aws_security_group.cicd.name
  ]

  tags = {
    Name = "cicd-${terraform.workspace}"
  }
}

resource "aws_instance" "lb" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.lb_instance_type
  key_name                    = aws_key_pair.ssh-access.key_name
  associate_public_ip_address = true

  security_groups = [
    aws_security_group.default-access.name,
    aws_security_group.lb.name
  ]

  tags = {
    Name = "lb-${terraform.workspace}"
  }
}

resource "aws_instance" "jboss" {
  count = 2

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.jboss_instance_type
  key_name                    = aws_key_pair.ssh-access.key_name
  associate_public_ip_address = true

  security_groups = [
    aws_security_group.default-access.name,
    aws_security_group.jboss.name
  ]

  tags = {
    Name = "jboss-${count.index}-${terraform.workspace}"
  }
}

resource "aws_instance" "mon" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.mon_instance_type
  key_name                    = aws_key_pair.ssh-access.key_name
  associate_public_ip_address = true

  security_groups = [
    aws_security_group.default-access.name,
    aws_security_group.mon.name
  ]

  tags = {
    Name = "mon-${terraform.workspace}"
  }
}
