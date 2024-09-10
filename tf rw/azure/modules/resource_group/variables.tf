variable "rg_name" {
  type = string
}
variable "location" {
  type = string
}
variable "tags" {
  type        = map(string)
  description = "Rockwell Required tags to deploy Azure resources"
}
