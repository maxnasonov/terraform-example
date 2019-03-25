resource "aws_s3_bucket" "app" {
  bucket = "app-artifact.nasonov.me"
}

resource "aws_s3_bucket_object" "app" {
  bucket = "${aws_s3_bucket.app.id}"
  key    = "app-v1.zip"
  source = "app-v1.zip"
}

resource "aws_elastic_beanstalk_application" "default" {
  name        = "${var.name}"
  description = "${var.description}"
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "tf-test-version-label"
  application = "${var.name}"
  description = "application version created by terraform"
  bucket      = "${aws_s3_bucket.app.id}"
  key         = "${aws_s3_bucket_object.app.id}"
}

