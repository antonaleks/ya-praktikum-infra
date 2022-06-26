variable "yc_region" {
  description = "yandex cloud region"
  type        = string
  default     = "ru-central1-a"
}

variable "yc_region_slave" {
  description = "yandex cloud region slave"
  type        = string
  default     = "ru-central1-b"
}

variable "yc_folder_id" {
  description = "yandex cloud folder id"
  type        = string
  default     = "b1g12usbo8ah1taf4bfb"
}

variable "yc_cloud_id" {
  description = "yandex cloud id"
  type        = string
  default     = "b1g3jddf4nv5e9okle7p"
}

variable "yc_token" {
  description = "yandex cloud token"
  type        = string
  default     = ""
}

variable "vm_resource_preset_id" {
  description = "vm resource preset id"
  type        = string
  default     = "s2.micro"
}

variable "database_username" {
  description = "Username of database administrator"
  type        = string
  sensitive   = true
}

variable "database_name" {
  description = "Name of database"
  type        = string
  default     = "sausage-store-db"
}

variable "database_password" {
  description = "Password of database administrator"
  type        = string
  sensitive   = true
}

