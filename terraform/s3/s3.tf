resource "aws_s3_bucket" "bucket_applicationversion" {
  bucket = "bucket-applicationversion"
}

resource "aws_s3_object" "bucket_object" {
  bucket = aws_s3_bucket.bucket_applicationversion.id
  key    = "application.zip"
  source = "../application/application.zip"
}

