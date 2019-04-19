
variable "name" {
  description = "AWS App Name"
  type      = "string"
  default   = "webserver"
}

variable "template" {
  description = "Template para criar a instancia, utilize apache ou nginx"
  type      = "string"
}

variable "type" {
  description = "AWS Instance Flavor Type"
  type      = "string"
  default   = "t2.small"
}

variable "cidr" {
  description = "Network CIDR, Formato: 192.168.XX.0/24 (Onde XX sera o num. de sua maq. por exemplo 192.168.5.0/24 ou 192.168.12.0/24)"
  type        = "string"
}

variable "ami" {
  description = "CoreOS AMI"
  type        = "string"
  default     = "ami-08e58b93705fb503f"
}

variable "turma" {
  type    = "string"
  default = "43SEG"
}

variable "RM" {
  type    = "string"
}

variable "zone_id" {
  type      = "string"
  default   = "Z35E0MU3IBLUWF"
}

variable "zone_name" {
  type      = "string"
  default   = "fiapdev.com"
}