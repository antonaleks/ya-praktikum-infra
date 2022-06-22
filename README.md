# Get started with the project
```shell
terraform init
terraform plan -var yc_token=${YC_TOKEN}
terraform apply -var yc_token=${YC_TOKEN}
terraform destroy -var yc_token=${YC_TOKEN}
```
Need to export ${YC_TOKEN} with yc token value