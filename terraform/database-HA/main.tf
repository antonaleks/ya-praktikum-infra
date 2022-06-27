resource "yandex_mdb_postgresql_cluster" "vm-postgres-HA" {
  name        = "anton-alekseev-postgres-cluster-HA"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.sausage-store-net.id

  config {
    version = 13
    resources {
      resource_preset_id = var.vm_resource_preset_id
      disk_type_id       = "network-ssd"
      disk_size          = 20
    }
  }

  host {
    zone             = var.yc_region
    subnet_id        = yandex_vpc_subnet.sausage-store-subnet-A.id
    assign_public_ip = true
  }

  host {
    zone             = var.yc_region_slave
    subnet_id        = yandex_vpc_subnet.sausage-store-subnet-B.id
    assign_public_ip = true
  }
}

resource "yandex_mdb_postgresql_user" "admin" {
  cluster_id = yandex_mdb_postgresql_cluster.vm-postgres-HA.id
  name       = var.database_username
  password   = var.database_password
  conn_limit = 50
  settings = {
    default_transaction_isolation = "read committed"
    log_min_duration_statement    = 5000
  }
}

resource "yandex_mdb_postgresql_database" "database" {
  cluster_id = yandex_mdb_postgresql_cluster.vm-postgres-HA.id
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
      PSQL_HOST     = "c-${yandex_mdb_postgresql_cluster.vm-postgres-HA.id}.rw.mdb.yandexcloud.net",
      PSQL_DBNAME   = yandex_mdb_postgresql_database.database.name
    }
  )
  filename = "data/.env"
}

resource "yandex_vpc_network" "sausage-store-net" {
  name = "sausage-store-net-HA"
}

resource "yandex_vpc_subnet" "sausage-store-subnet-A" {
  zone           = var.yc_region
  network_id     = yandex_vpc_network.sausage-store-net.id
  v4_cidr_blocks = ["10.26.10.0/24"]
}

resource "yandex_vpc_subnet" "sausage-store-subnet-B" {
  zone           = var.yc_region_slave
  network_id     = yandex_vpc_network.sausage-store-net.id
  v4_cidr_blocks = ["10.26.20.0/24"]
}