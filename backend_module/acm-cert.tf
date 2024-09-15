# # acm.tf
# resource "aws_acm_certificate" "example_cert" {
#   domain_name       = "mysite.example.com" # Your primary domain
#   subject_alternative_names = ["yoursite.example.com"] # Additional domains
#   validation_method = "DNS"

#   tags = {
#     Name = "ACM Certificate for CloudFront"
#   }
# }