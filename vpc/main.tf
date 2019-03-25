data "aws_region" "current" {}

resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.name}"
    terraform = "true"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.name}-igw"
    terraform = "true"
  }
}

resource "aws_route53_zone" "private" {
  name = "example.com"

  vpc {
    vpc_id = "${aws_vpc.vpc.id}"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.vpc.id}"
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
}

