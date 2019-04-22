terraform {
  backend "s3" {
    bucket = "terraform.fiap.site"
    key    = "infrastructure/aws/XXXXX"
    region = "us-east-1"
  }
}

data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}

data "aws_security_group" "selected" {
  id = "${var.sg_id}"
}

resource "aws_instance" "webserver" {
  ami                         = "${var.ami}"
  instance_type               = "${var.type}"
  count                       = "1"
  user_data                   = "${file("../../templates/${var.template}.yaml")}"
  associate_public_ip_address = true

  tags {
    Name          = "${var.name}"
    turma         = "${var.turma}"
    RM            = "${var.RM}"
  }
}

output "public-dns" {
  value = ["${aws_instance.webserver.*.public_dns}"]
}
