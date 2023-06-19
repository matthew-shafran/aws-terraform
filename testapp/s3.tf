resource "aws_s3_bucket" "this" {
  bucket = "mshafran-s3-${local.app_code}-${var.environment_code}"
}