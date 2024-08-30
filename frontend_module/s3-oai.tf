
variable "cf_origin_id" {
  description = "The identifier for the CloudFront origin"
  type        = string
  default     = "S3-origin" # Change as needed
}

# oai.tf
resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for accessing ${var.bucket_name}"
}
