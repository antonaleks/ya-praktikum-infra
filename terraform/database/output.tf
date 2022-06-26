output "db_hostname" {
  value = flatten(yandex_mdb_postgresql_cluster.vm-postgres.host[*].fqdn)
}