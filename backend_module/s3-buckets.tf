
# Create an S3 bucket
resource "aws_s3_bucket" "s3-prod-bucket" {
  bucket = "${var.environment}-${var.company_name}-primary-bucket"

  tags = {
    Name        = "s3-prod-bucket"
    Environment = "Production"
  }
}
