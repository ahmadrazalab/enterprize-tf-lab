resource "null_resource" "upload_build_s3_files" {
  provisioner "local-exec" {
    command = "aws s3 cp ./dash s3://${var.static_site_bucket_name} --recursive"
  }
  depends_on = [aws_s3_bucket.prod_static_site]
}