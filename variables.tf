variable "project" {
  description = "project"
}
variable "region" {
  description = "region"
  default    = "europe-west2"
}

variable "namespace" {
  type        = string
  description = "The Namespace name"
  default    = "jlr-poc"
}

variable "linux_instance_type" {
  type        = string
  description = "VM instance type"
   default    = "f1-micro"
}

variable "network-subnet-cidr" {
  type        = string
  description = "The CIDR for the network subnet"
  default    = "10.2.0.0/16"
}


variable "sku" {
  type        = string
  description = "SKU for Ubuntu 18.04 LTS"
  default     = "ubuntu-os-cloud/ubuntu-1804-lts"
}

variable "ssh_pub_key_file" {
  type        = string
  description = "ssh_pub_key_file"

}
