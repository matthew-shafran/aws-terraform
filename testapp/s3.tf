resource "aws_s3_bucket" "this" {
  provider  = aws.test-app_account
  bucket    = "mshafran-s3-${local.app_code}-${var.environment_code}"
}