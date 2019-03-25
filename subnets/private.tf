locals {
  private_subnet_count = "${var.max_subnet_count == 0 ? length(data.aws_availability_zones.available.names) : var.max_subnet_count}"
}

resource "aws_subnet" "private" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${data.aws_vpc.vpc.id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  cidr_block        = "${cidrsubnet(signum(length(var.cidr_block)) == 1 ? var.cidr_block : data.aws_vpc.vpc.cidr_block, ceil(log(local.private_subnet_count * 2, 2)), count.index)}"
}

resource "aws_route_table" "private" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${data.aws_vpc.vpc.id}"
}

resource "aws_route_table_association" "private" {
  count = "${length(var.availability_zones)}"

  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_network_acl" "private" {
  count      = "${signum(length(var.private_network_acl_id)) == 0 ? 1 : 0}"
  vpc_id     = "${var.vpc_id}"
  subnet_ids = ["${aws_subnet.private.*.id}"]

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

}

data "aws_vpc_endpoint" "s3" {
  vpc_id       = "${var.vpc_id}"
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  count = "${length(var.availability_zones)}"
  vpc_endpoint_id = "${data.aws_vpc_endpoint.s3.id}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
