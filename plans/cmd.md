terraform graph -type=plan | dot -Tpng >graph.png
terraform plan -out=<file-name>
terraform show <file-name>


terraform fmt
terraform validate
terraform apply -auto-approve
terraform destroy -auto-approve



terraform plan -target=module.frontend
terraform apply -target=module.frontend


# issues 
## issue 
segregate outputs of data in single file for each module 
setup terrafrom.tfvars for variable substitution
naming convention should me proper 


## issue backend

## issue frontend

## issue vpc





## Update 
- read replica rds 
- implement Secret Manager 
- access RDS, secretM, S3 using IAM role by ec2 instance 
- parameter group for rds for slow query logging
- activate custom VPC for other modules (backend and frontend)