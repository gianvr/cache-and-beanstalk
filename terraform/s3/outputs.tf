output "bucket_id" {
  value = aws_s3_bucket.bucket_applicationversion.id
}
  
output "bucket_object_id" {
  value = aws_s3_object.bucket_object.id
}