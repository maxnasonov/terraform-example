variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = "string"
}

variable "cidr" {
  type        = "string"
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}
