# outputs.tf
output "cloudfront_domain_dash" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.dashboard_distribution.domain_name
}


output "cloudfront_domain_cdn" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.cdn_distribution.domain_name
}


output "cloudfront_domain_checkout" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.checkout_distribution.domain_name
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.s3-static-site-paytring.bucket
}