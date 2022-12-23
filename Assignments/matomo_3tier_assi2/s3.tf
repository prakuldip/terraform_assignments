resource "aws_s3_bucket" "matomo-log-bucket" {
  bucket = "matomo-web-app-log-bukcet"
}

resource "aws_s3_bucket_public_access_block" "pub-access-block" {
  bucket = aws_s3_bucket.matomo-log-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}