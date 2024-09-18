# modules/custom_cloudfront_distribution/main.tf
resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = var.bucket_regional_domain_name
    origin_id   = var.origin_id

    s3_origin_config {
      origin_access_identity = var.oai_path
    }
    origin_path = var.origin_path
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution for ${var.origin_id}"
  default_root_object = var.default_root_object

  aliases = var.aliases

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.origin_id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # viewer_certificate {
  #   cloudfront_default_certificate = true
  # }
  viewer_certificate {
    acm_certificate_arn      = var.aws_acm_certificate_us
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }



  tags = merge(
    {
      Name        = "CloudFront Distribution for ${var.origin_id}"
      Environment = var.environment
    },
    var.additional_tags
  )
}