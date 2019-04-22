terraform {
  backend "s3" {
    bucket = "terraform.fiap.site"
    key    = "infrastructure/aws/XXXX"
    region = "us-east-1"
  }
}

resource "aws_vpc" "webserver" {
  cidr_block = "${var.cidr}"

  tags {
    name          = "${var.name}"
    turma         = "${var.turma}"
    Group         = "${var.Group}"
  }
} 

resource "aws_subnet" "subnet-webserver" {
  vpc_id                    = "${aws_vpc.webserver.id}"
  map_public_ip_on_launch   = true
  cidr_block                = "${var.cidr}"
  availability_zone         = "us-east-1a"


  tags {
    name          = "${var.name}"
    turma         = "${var.turma}"
    Group         = "${var.Group}"
  }
}

resource "aws_internet_gateway" "igw-webserver" {
  vpc_id    = "${aws_vpc.webserver.id}"

  tags {
    name          = "${var.name}"
    turma         = "${var.turma}"
    Group         = "${var.Group}"
  }
}

resource "aws_eip" "eip-webserver" {
  instance = "${aws_instance.webserver.id}"
  vpc      = true

  tags {
    name          = "${var.name}"
    turma         = "${var.turma}"
    Group         = "${var.Group}"
    }  
}

resource "aws_route53_record" "record-webserver" {
  zone_id = "${var.zone_id}"
  name    = "${var.Group}.${var.zone_name}"
  type    = "A"
  ttl     = "60"
  records = ["${aws_eip.eip-webserver.public_ip}"]
}

resource "aws_default_route_table" "webserver" {
  default_route_table_id = "${aws_vpc.webserver.default_route_table_id}"

  tags {
    name          = "${var.name}"
    turma         = "${var.turma}"
    Group         = "${var.Group}"
    }

route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw-webserver.id}"
  }
}

resource "aws_security_group" "webserver" {
  name        = "webserver"
  description = "Allow traffic for 80, 443 and internal to 22"
  vpc_id = "${aws_vpc.webserver.id}"

  tags {
    name          = "${var.name}"
    turma         = "${var.turma}"
    Group         = "${var.Group}"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "webserver" {
  ami                         = "${var.ami}"
  instance_type               = "${var.type}"
  count                       = "1"
  user_data                   = "${file("../../templates/${var.template}.yaml")}"
  subnet_id                   = "${aws_subnet.subnet-webserver.id}"
  associate_public_ip_address = false
  security_groups             = ["${aws_security_group.webserver.id}"]

  tags {
    Name          = "${var.name}"
    turma         = "${var.turma}"
    Group         = "${var.Group}"
  }
}

output "eip" {
  value = "${aws_eip.eip-webserver.public_ip}"
}
