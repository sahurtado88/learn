# TF Control variable
variable "acr_manage" {
  default = "true"
}

variable "acr_name" {}

variable "location_pair" {
  default = "westus2"
  type    = string
}

variable "env_name" {
  type = string
}
