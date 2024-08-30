terraform graph -type=plan | dot -Tpng >graph.png
terraform plan -out=<file-name>
terraform show <file-name>


terraform fmt
terraform validate
terraform apply -auto-approve
terraform destroy -auto-approve



terraform plan -target=module.frontend
terraform apply -target=module.frontend
