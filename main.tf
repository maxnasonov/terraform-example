provider "aws" {
  region = "${var.region}"
  #shared_credentials_file = "/Users/nasonov/.aws/credentials"
  #profile = "${var.aws_profile}"
}

variable "max_availability_zones" {
  default = "2"
}

data "aws_availability_zones" "available" {}

resource "aws_key_pair" "default" {
  key_name   = "default-kp"
  public_key = "${var.public_key}"
}

module "vpc" {
  source = "./vpc"
  name = "${var.vpc_name}"
  cidr = "${var.vpc_cidr}"
}

module "subnets" {
  source              = "./subnets"
  availability_zones  = ["${slice(data.aws_availability_zones.available.names, 0, var.max_availability_zones)}"]
  region              = "${var.region}"
  vpc_id              = "${module.vpc.vpc_id}"
  igw_id              = "${module.vpc.igw_id}"
  cidr_block          = "${module.vpc.vpc_cidr_block}"
}

module "elastic_beanstalk_application" {
  source      = "./eb_app"
  name        = "${var.vpc_name}"
  description = "app"
}

module "elastic_beanstalk_environment" {
  source    = "./eb_env"
  zone_id   = "${module.vpc.route53_zone_id}"
  app       = "${module.elastic_beanstalk_application.app_name}"
  vpc_name  = "${var.vpc_name}"

  instance_type           = "t2.small"
  autoscale_min           = 2
  autoscale_max           = 4
  updating_min_in_service = 1
  updating_max_batch      = 1

  #loadbalancer_type   = "application"
  loadbalancer_type   = "classic"
  vpc_id              = "${module.vpc.vpc_id}"
  public_subnets      = "${module.subnets.public_subnet_ids}"
  private_subnets     = "${module.subnets.private_subnet_ids}"
  security_groups     = ["${module.vpc.vpc_default_security_group_id}"]
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.8.7 running PHP 7.1"
  keypair             = "${aws_key_pair.default.key_name}"

  autoscale_upper_bound = "40"
  #healthcheck_url       = "/ping.html"
  healthcheck_url       = "/"
  #loadbalancer_certificate_arn = "${var.ssl_certificate_arn}"
  #notification_endpoint = "${var.notification_email}"
  http_listener_enabled = "true"

#  env_vars = "${
#    map(
#      "APP_BASE_URL", "crabbr.com",
#      "APP_DEBUG", "false",
#      "APP_ENV", "production"
#    )
#  }"
}
