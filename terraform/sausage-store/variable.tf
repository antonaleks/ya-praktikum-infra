variable "yc_region" {
  description = "yandex cloud region"
  type        = string
  default     = "ru-central1-a"
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

variable "vm_cores" {
  description = "vm core"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "vm memory"
  type        = number
  default     = 2
}

variable "vm_count" {
  description = "vm count"
  type        = number
  default     = 2
}
