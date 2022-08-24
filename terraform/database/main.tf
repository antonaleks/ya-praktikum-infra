resource "yandex_mdb_postgresql_cluster" "vm-postgres" {
  name        = "anton-alekseev-postgres-single"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.sausage-store-net.id

  config {
    version = 13
    resources {
      resource_preset_id = var.vm_resource_preset_id
      disk_type_id       = "network-ssd"
      disk_size          = 20
    }
    postgresql_config = {
      max_connections                   = 100
      enable_parallel_hash              = true
      vacuum_cleanup_index_scale_factor = 0.2
      autovacuum_vacuum_scale_factor    = 0.34
      default_transaction_isolation     = "TRANSACTION_ISOLATION_READ_COMMITTED"
      shared_preload_libraries          = "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN,SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN"
    }
  }

  host {
    zone             = var.yc_region
    subnet_id        = yandex_vpc_subnet.sausage-store-subnet.id
    assign_public_ip = true
  }

}
resource "yandex_mdb_postgresql_user" "admin" {
  cluster_id = yandex_mdb_postgresql_cluster.vm-postgres.id
  name       = var.database_username
  password   = var.database_password
  conn_limit = 10
  settings = {
    default_transaction_isolation = "read committed"
    log_min_duration_statement    = 5000
  }
}

resource "yandex_mdb_postgresql_database" "database" {
  cluster_id = yandex_mdb_postgresql_cluster.vm-postgres.id
  name       = var.database_name
  owner      = yandex_mdb_postgresql_user.admin.name
  lc_collate = "en_US.UTF-8"
  lc_type    = "en_US.UTF-8"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("../resources/.env.tmpl",
    {
      PSQL_ADMIN    = yandex_mdb_postgresql_user.admin.name,
      PSQL_PASSWORD = yandex_mdb_postgresql_user.admin.password,
      PSQL_HOST     = yandex_mdb_postgresql_cluster.vm-postgres.host[0].fqdn,
      PSQL_DBNAME   = yandex_mdb_postgresql_database.database.name
    }
  )
  filename = "data/.env"
}

resource "yandex_vpc_network" "sausage-store-net" {
  name = "sausage-store-net"
}

resource "yandex_vpc_subnet" "sausage-store-subnet" {
  zone           = var.yc_region
  network_id     = yandex_vpc_network.sausage-store-net.id
  v4_cidr_blocks = ["10.26.1.0/24"]
}
