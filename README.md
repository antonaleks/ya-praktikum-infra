# Get started with the terraform
```shell
cd terraform/hometask
terraform init
terraform plan -var yc_token=${YC_TOKEN}
terraform apply -var yc_token=${YC_TOKEN}
terraform destroy -var yc_token=${YC_TOKEN}
```
Need to export ${YC_TOKEN} with yc token value
after apply terraform will create inventory for ansible

# Get started with ansible
```shell
cd ansible
ansible-playbook playbook -i inventory
```
you need to insert nexus repo login/password to console after run playbook