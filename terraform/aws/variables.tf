
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

variable "vpc_id" {
  type	    = "string"
  default   = "vpc-97d996f3"
}
