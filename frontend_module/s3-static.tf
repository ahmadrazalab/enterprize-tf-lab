# variables.tf
variable "bucket_name" {
  description = "s3-static-site-paytring"
  type        = string
  default     = "s3-static-site-paytring" # Change as needed
}

# # Create an S3 bucket
resource "aws_s3_bucket" "s3-static-site-paytring" {
  bucket = var.bucket_name

  tags = {
    Name        = "s3-static-site-paytring"
    Environment = "Production"
  }
}




# s3_policy.tf
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.s3-static-site-paytring.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.s3-static-site-paytring.arn}/*"
      }
    ]
  })
}