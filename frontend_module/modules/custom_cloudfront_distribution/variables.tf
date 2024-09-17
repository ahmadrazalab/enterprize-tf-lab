
# modules/custom_cloudfront_distribution/variables.tf
variable "aws_acm_certificate_us" {
  description = "ACM SSL Certificate"
  type        = string
}

variable "bucket_regional_domain_name" {
  description = "The regional domain name of the S3 bucket"
  type        = string
}

variable "origin_id" {
  description = "The unique identifier for the origin"
  type        = string
}

variable "origin_path" {
  description = "The path to the content in the S3 bucket"
  type        = string
}

variable "default_root_object" {
  description = "The default root object for the CloudFront distribution"
  type        = string
}

variable "aliases" {
  description = "List of aliases (domain names) for the CloudFront distribution"
  type        = list(string)
}

variable "oai_path" {
  description = "The CloudFront Origin Access Identity path"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, dev, staging)"
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to add to resources"
  type        = map(string)
  default     = {}
}

variable "price_class" {
  description = "CloudFront distribution price class"
  type        = string
}

variable "allowed_methods" {
  description = "HTTP methods that CloudFront processes and forwards to your Amazon S3 bucket or your custom origin"
  type        = list(string)
}

variable "cached_methods" {
  description = "HTTP methods for which CloudFront caches responses"
  type        = list(string)
}

variable "min_ttl" {
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
  type        = number
}

variable "default_ttl" {
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
  type        = number
}

variable "max_ttl" {
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
  type        = number
}