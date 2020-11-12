#####
# creates a new SSH keypair
#####

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ssh-access" {
  key_name   = "${terraform.workspace}-keypair"
  public_key = tls_private_key.key.public_key_openssh
}


#####
# limit access to machines
#####

resource "aws_security_group" "default-access" {
  name = "${terraform.workspace}-default-access"
    vpc_id = data.aws_vpc.selected.id

  dynamic "ingress" {
    for_each = var.ingress_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"
      ]
    }
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


#####
# spin up all required EC2 instances
#####

resource "aws_instance" "server" {
  count = length(var.instance_names)

  ami                         = data.aws_ami.centos7.id
  instance_type               = var.instance_type
  availability_zone           = var.aws_az
  key_name                    = aws_key_pair.ssh-access.key_name
  associate_public_ip_address = true

  security_groups = [
    aws_security_group.default-access.name
  ]

  tags = {
    Name = "${terraform.workspace}-${var.instance_names[count.index]}"
  }
}
