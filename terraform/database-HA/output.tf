output "db_hostname" {
  value = [flatten(yandex_mdb_postgresql_cluster.vm-postgres-HA.host[*].fqdn),
    yandex_mdb_postgresql_cluster.vm-postgres-HA.id
  ]
}

output "db_users" {
  value = [flatten(var.database_user_list[*]),
    flatten(random_password.password[*].result)
  ]
  sensitive = true
}
