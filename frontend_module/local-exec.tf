# resource "null_resource" "upload_build_s3_files" {
#   provisioner "local-exec" {
#     command = "aws s3 cp ./dash s3://${var.bucket_name} --recursive"
#   }

#   depends_on = [aws_s3_bucket.s3-static-site-paytring]
# }