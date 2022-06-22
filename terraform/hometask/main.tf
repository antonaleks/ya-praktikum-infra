resource "yandex_compute_instance" "vm-1" {
  name  = "chapter5-lesson2-anton-alekseyev-${count.index}"
  count = var.vm_count
  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32"
    }
  }

  network_interface {
    subnet_id = "e9buqdtk932abpsvrje1"
    nat       = true
  }

  metadata = {
    user-data = "${file("../resources/meta.txt")}"
  }
}