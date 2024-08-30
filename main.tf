# main.tf in the root directory
module "frontend" {
  source = "./frontend_module"
  # Add any required variables
  # e.g., bucket_name = var.bucket_name
}
