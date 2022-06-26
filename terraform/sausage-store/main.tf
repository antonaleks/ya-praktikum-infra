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

resource "local_file" "ansible_inventory" {
  content = templatefile("../resources/inventory.tmpl",
    {
      backend_vm_ip_nat  = yandex_compute_instance.vm-1[0].network_interface.0.nat_ip_address,
      frontend_vm_ip_nat = yandex_compute_instance.vm-1[1].network_interface.0.nat_ip_address
      backend_vm_ip      = yandex_compute_instance.vm-1[0].network_interface.0.ip_address,
      frontend_vm_ip     = yandex_compute_instance.vm-1[1].network_interface.0.ip_address
    }
  )
  filename = "../../ansible/inventory"
}