output "ip_address" {
  value = [
    flatten(yandex_compute_instance.vm-1[*].network_interface.0.ip_address),
    flatten(yandex_compute_instance.vm-1[*].network_interface.0.nat_ip_address)
  ]
}