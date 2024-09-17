# Terraform AWS CloudFront Distribution

This project uses Terraform to set up and manage AWS CloudFront distributions for a static website, checkout process, and other custom distributions on Amazon S3.

## Project Structure

- `main.tf`: Main Terraform configuration file
- `variables.tf`: Input variables for the Terraform configuration
- `outputs.tf`: Output values from the Terraform configuration
- `providers.tf`: Provider configuration for AWS
- `modules/`: Custom Terraform modules
  - `cloudfront_distribution/`: Standard CloudFront distribution module
  - `custom_cloudfront_distribution/`: Customizable CloudFront distribution module

## Requirements

- Terraform v0.12+
- AWS CLI configured with appropriate credentials
- An Amazon S3 bucket to host your static website content

## Usage

1. Clone this repository
2. Update the `variables.tf` file with your desired values
3. Run `terraform init` to initialize the Terraform working directory
4. Run `terraform plan` to see the execution plan
5. Run `terraform apply` to create the resources
6. After the resources are created, upload your static website content to the S3 bucket

## Variables

Key variables include:

- `static_site_bucket_name`: Name of the S3 bucket for the static site
- `environment`: Environment name (e.g., prod, dev, staging)
- `cloudfront_price_class`: CloudFront distribution price class
- `cloudfront_allowed_methods`: HTTP methods that CloudFront processes and forwards
- `cloudfront_cached_methods`: HTTP methods for which CloudFront caches responses
- `cloudfront_min_ttl`: Minimum time for objects to stay in CloudFront caches
- `cloudfront_default_ttl`: Default time for objects in CloudFront cache
- `cloudfront_max_ttl`: Maximum time for objects in CloudFront cache

For a complete list of variables and their descriptions, please refer to the `variables.tf` file.

## Modules

### custom_cloudfront_distribution

This module creates a customizable CloudFront distribution. It allows you to specify:

- Origin domain name
- Allowed HTTP methods
- Cached HTTP methods
- Price class
- TTL settings (minimum, default, maximum)
- And more

## Outputs

- `cdn_distribution_domain`: The domain name of the CDN CloudFront distribution
- `checkout_distribution_domain`: The domain name of the checkout CloudFront distribution

Use these domain names to access your CloudFront-distributed content.

## Security

This project uses AWS CloudFront Origin Access Identity (OAI) to secure access to the S3 bucket. Only CloudFront can access the S3 bucket directly.

## Customization

You can customize the CloudFront distributions by modifying the `custom_cloudfront_distribution` module calls in `main.tf`. Adjust the input variables to change behaviors such as allowed methods, TTL settings, and more.

## License

[Specify your license here]

## Contributing

[Add contributing guidelines if applicable]

## Support

For support, please open an issue in the GitHub repository or contact [your contact information].

## Disclaimer

This project is provided as-is, without any guarantees or warranty. Users are responsible for ensuring that their use of this code complies with all applicable laws and regulations.