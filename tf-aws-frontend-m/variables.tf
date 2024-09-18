# variables.tf
variable "aws_acm_cetificate_us" {
  description = "ACM SSL Certificate"
  type        = string
}


variable "company_name" {
  description = "The name of the company"
  type        = string
  default     = "ahmadraza.in"
}


variable "static_site_bucket_name" {
  description = "Name of the S3 bucket for static site"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, dev, staging)"
  type        = string
  default     = "prod"
}

variable "additional_tags" {
  description = "Additional tags to add to resources"
  type        = map(string)
  default     = {}
}

variable "cdn_origin_path" {
  description = "Origin path for CDN distribution"
  type        = string
  default     = "/cdn"
}

variable "cdn_default_root_object" {
  description = "Default root object for CDN distribution"
  type        = string
  default     = "index.html"
}

variable "cdn_domain_name" {
  description = "Domain name for CDN distribution"
  type        = string
}

variable "checkout_origin_path" {
  description = "Origin path for checkout distribution"
  type        = string
  default     = "/checkout"
}

variable "checkout_default_root_object" {
  description = "Default root object for checkout distribution"
  type        = string
  default     = "index.html"
}

variable "checkout_domain_name" {
  description = "Domain name for checkout distribution"
  type        = string
}

variable "dashboard_origin_path" {
  description = "Origin path for dashboard distribution"
  type        = string
  default     = "/dashboard"
}

variable "dashboard_default_root_object" {
  description = "Default root object for dashboard distribution"
  type        = string
  default     = "index.html"
}

variable "dashboard_domain_name" {
  description = "Domain name for dashboard distribution"
  type        = string
}

variable "cloudfront_price_class" {
  description = "CloudFront distribution price class"
  type        = string
  default     = "PriceClass_100"
}

variable "cloudfront_allowed_methods" {
  description = "HTTP methods that CloudFront processes and forwards to your Amazon S3 bucket or your custom origin"
  type        = list(string)
  default     = ["GET", "HEAD"]
  # default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cloudfront_cached_methods" {
  description = "HTTP methods for which CloudFront caches responses"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cloudfront_min_ttl" {
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
  type        = number
  default     = 0
}

variable "cloudfront_default_ttl" {
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
  type        = number
  default     = 3600
}

variable "cloudfront_max_ttl" {
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
  type        = number
  default     = 86400
}