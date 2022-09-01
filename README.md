# Get started with the terraform
```shell
cd terraform/sausage-store
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

# Databases clusters
```yaml
- db_type: single
  hostname: rc1a-n5tu7pmc383z1kuw.mdb.yandexcloud.net
  port: 6432
  user:
    name: db-service
    password: qWerty123
  db_name: sausage-store-db
- db_type: cluster
  hostname:
    - rc1a-dvctnks1cgkfj40s.mdb.yandexcloud.net
    - rc1b-ikc20hb1iavqfgem.mdb.yandexcloud.net
  port: 6432
  user:
    name: db-service
    password: qWerty123
  db_name: sausage-store-db
```
