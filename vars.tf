variable "aws_profile" {
  description = "AWS profile name"
  type        = "string"
  default     = "default"
}

variable "vpc_name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = "string"
}

variable "vpc_cidr" {
  type        = "string"
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}

variable "region" {
  description = "The AWS region to create things in."
  default = "us-east-1"
}

variable "public_key" {
  description = "Public key content to use in EC2."
}
