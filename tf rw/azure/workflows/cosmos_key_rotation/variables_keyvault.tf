variable "secret_expiry_period" {
  type    = number
  default = 365
}

variable "cosmosdb-primary-readonly-connection-string" {
  default = "cosmosdb-primary-readonly-connection-string"
  type    = string
}

variable "cosmosdb-secondary-readonly-connection-string" {
  default = "cosmosdb-secondary-readonly-connection-string"
  type    = string
}

variable "cosmosdb-primary-readwrite-connection-string" {
  default = "cosmosdb-primary-readwrite-connection-string"
  type    = string
}

variable "cosmosdb-secondary-readwrite-connection-string" {
  default = "cosmosdb-secondary-readwrite-connection-string"
  type    = string
}

