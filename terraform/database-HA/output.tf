output "db_hostname" {
  value = [flatten(yandex_mdb_postgresql_cluster.vm-postgres-HA.host[*].fqdn),
    yandex_mdb_postgresql_cluster.vm-postgres-HA.id
  ]
}