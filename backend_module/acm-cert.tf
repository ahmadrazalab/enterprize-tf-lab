# acm.tf
resource "aws_acm_certificate" "prod_cert" {
  domain_name       = "*.ahmadraza.in"
  validation_method = "DNS"

  tags = {
    Name        = "Wildcard Certificate for ahmadraza.in"
    Environment = "production"
  }
}