# Курс Яндекс.Практикум DevOps для эксплуатации и разработки
Данный репозиторий содержит инфраструктурный код, использованный в рамках курса от Яндекс Практикума.
[Тут](https://github.com/antonaleks/ya-praktikum-app) лежит репозиторий приложения.
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

# Get started with Kubernetes
You need to export KUBE_CONFIG
```shell
kubectl apply -f backend backend-report frontend
```
# Get started with Helm
You need to export KUBE_CONFIG
```shell
helm install sausage-store ./sausage-store-chart
```
