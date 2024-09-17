# main.tf
resource "aws_s3_bucket" "prod_static_site" {
  bucket = var.static_site_bucket_name

  tags = merge(
    {
      Name        = "${var.environment}-${var.static_site_bucket_name}"
      Environment = var.environment
    },
    var.additional_tags
  )
}

resource "aws_s3_bucket_policy" "prod_static_site_policy" {
  bucket = aws_s3_bucket.prod_static_site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.prod_oai.iam_arn
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.prod_static_site.arn}/*"
      }
    ]
  })
}

resource "aws_cloudfront_origin_access_identity" "prod_oai" {
  comment = "OAI for static site bucket"
}

module "cdn_distribution" {
  source = "./modules/custom_cloudfront_distribution"

  bucket_regional_domain_name = aws_s3_bucket.prod_static_site.bucket_regional_domain_name
  origin_id                   = "${var.environment}-${var.static_site_bucket_name}-cdn"
  origin_path                 = var.cdn_origin_path
  default_root_object         = var.cdn_default_root_object
  aliases                     = [var.cdn_domain_name]
  oai_path                    = aws_cloudfront_origin_access_identity.prod_oai.cloudfront_access_identity_path
  environment                 = var.environment
  additional_tags             = var.additional_tags
  price_class                 = var.cloudfront_price_class
  allowed_methods             = var.cloudfront_allowed_methods
  cached_methods              = var.cloudfront_cached_methods
  min_ttl                     = var.cloudfront_min_ttl
  default_ttl                 = var.cloudfront_default_ttl
  max_ttl                     = var.cloudfront_max_ttl
  aws_acm_certificate_us      = var.aws_acm_cetificate_us

}

module "checkout_distribution" {
  source = "./modules/custom_cloudfront_distribution"

  bucket_regional_domain_name = aws_s3_bucket.prod_static_site.bucket_regional_domain_name
  origin_id                   = "${var.environment}-${var.static_site_bucket_name}-checkout"
  origin_path                 = var.checkout_origin_path
  default_root_object         = var.checkout_default_root_object
  aliases                     = [var.checkout_domain_name]
  oai_path                    = aws_cloudfront_origin_access_identity.prod_oai.cloudfront_access_identity_path
  environment                 = var.environment
  additional_tags             = var.additional_tags
  price_class                 = var.cloudfront_price_class
  allowed_methods             = var.cloudfront_allowed_methods
  cached_methods              = var.cloudfront_cached_methods
  min_ttl                     = var.cloudfront_min_ttl
  default_ttl                 = var.cloudfront_default_ttl
  max_ttl                     = var.cloudfront_max_ttl
  aws_acm_certificate_us      = var.aws_acm_cetificate_us

}

module "dashboard_distribution" {
  source = "./modules/custom_cloudfront_distribution"

  bucket_regional_domain_name = aws_s3_bucket.prod_static_site.bucket_regional_domain_name
  origin_id                   = "${var.environment}-${var.static_site_bucket_name}-dashboard"
  origin_path                 = var.dashboard_origin_path
  default_root_object         = var.dashboard_default_root_object
  aliases                     = [var.dashboard_domain_name]
  oai_path                    = aws_cloudfront_origin_access_identity.prod_oai.cloudfront_access_identity_path
  environment                 = var.environment
  additional_tags             = var.additional_tags
  price_class                 = var.cloudfront_price_class
  allowed_methods             = var.cloudfront_allowed_methods
  cached_methods              = var.cloudfront_cached_methods
  min_ttl                     = var.cloudfront_min_ttl
  default_ttl                 = var.cloudfront_default_ttl
  max_ttl                     = var.cloudfront_max_ttl
  aws_acm_certificate_us      = var.aws_acm_cetificate_us

}