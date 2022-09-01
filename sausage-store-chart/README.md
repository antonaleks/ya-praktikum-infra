# Helm chart for sausage-store web application

## Usage
set <> as a environment variables
```
helm install --set secrets.vaultToken=<> --set secrets.vaultHost=<> --set secrets.postgresHost=<> --set secrets.postgresPort=<> --set secrets.postgresDBName=<> --set secrets.dockerConfigJson=<> sausage-store ./
```
to check containers installed
```
kubectl get pod
```
