

# # Create an S3 bucket

resource "aws_s3_bucket" "s3-prod-bucket-paytring" {
  bucket = "s3-prod-bucket-paytring"

  tags = {
    Name        = "s3-prod-bucket-paytring"
    Environment = "Production"
  }
}











# resource "aws_s3_bucket" "prod-bucket" {
#   bucket = "in-datacenter-v0-res"  # Replace with your desired bucket name
#   acl    = "private"

#   tags = {
#     Name        = "in-datacenter-v0-res"
#     Environment = "Dev"
#   }
# }

# # Enable versioning on the S3 bucket
# resource "aws_s3_bucket_versioning" "prod-bucket_versioning" {
#   bucket = aws_s3_bucket.my_bucket.id

#   versioning_configuration {
#     status = "Disabled"
#   }
# }

# # Optional: Set bucket policy to restrict access (example for public read)
# resource "aws_s3_bucket_policy" "prod-bucket_policy" {
#   bucket = aws_s3_bucket.prod-bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect   = "Allow"
#         Principal = "*"
#         Action   = "s3:GetObject"
#         Resource = "${aws_s3_bucket.prod-bucket.arn}/*"
#       }
#     ]
#   })
# }