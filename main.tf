// https://medium.com/@hmalgewatta/setting-up-an-aws-ec2-instance-with-ssh-access-using-terraform-c336c812322f

provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_vpc" "test-env" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
    Name = "test-env"
  }
}

//subnets.tf
resource "aws_subnet" "subnet-uno" {
  cidr_block = "${cidrsubnet(aws_vpc.test-env.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.test-env.id}"
  availability_zone = "us-east-1a"
}

//security.tf
resource "aws_security_group" "ingress-all-test" {
  name = "allow-all-sg"
  vpc_id = "${aws_vpc.test-env.id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  // Terraform removes the default rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "ami_name" {}
variable "ami_id" {}
variable "ami_key_pair_name" {}

//servers.tf
resource "aws_instance" "example" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.ingress-all-test.id}"]

  subnet_id = "${aws_subnet.subnet-uno.id}"

  tags {
    Name = "${var.ami_name}"
  }
}

output "image_id" {
  value = "${data.aws_ami.ubuntu.id}"
}

