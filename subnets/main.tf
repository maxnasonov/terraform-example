terraform {
  required_version = ">= 0.10.2"
}

# Get object aws_vpc by vpc_id
data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

data "aws_availability_zones" "available" {}

data "aws_region" "current" {}
