# outputs.tf
output "cdn_distribution_domain" {
  description = "The domain name of the CDN CloudFront distribution"
  value       = module.cdn_distribution.cloudfront_domain_name
}

output "checkout_distribution_domain" {
  description = "The domain name of the checkout CloudFront distribution"
  value       = module.checkout_distribution.cloudfront_domain_name
}

output "dashboard_distribution_domain" {
  description = "The domain name of the dashboard CloudFront distribution"
  value       = module.dashboard_distribution.cloudfront_domain_name
}

output "static_site_bucket_name" {
  description = "The name of the S3 bucket for the static site"
  value       = aws_s3_bucket.prod_static_site.id
}

output "cdn_distribution_id" {
  description = "The ID of the CDN CloudFront distribution"
  value       = module.cdn_distribution.cloudfront_distribution_id
}

output "checkout_distribution_id" {
  description = "The ID of the checkout CloudFront distribution"
  value       = module.checkout_distribution.cloudfront_distribution_id
}

output "dashboard_distribution_id" {
  description = "The ID of the dashboard CloudFront distribution"
  value       = module.dashboard_distribution.cloudfront_distribution_id
}