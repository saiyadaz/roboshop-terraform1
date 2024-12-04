variable "component" {
  default = "docdb"
}
variable "env" {}
variable "vpc_id" {}
variable "server_app_port_sg_cidr" {}
variable "family" {}
variable "subnet_ids" {}

variable "instance_count" {}
variable "instance_class" {}
variable "engine_version" {}
variable "kms_key_id" {}