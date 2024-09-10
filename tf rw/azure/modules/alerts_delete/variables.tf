variable "alert_name_suffix" {
  type = string
}

variable "rg_name_delete" {
  type = string
}

variable "category" {
  type    = string
  default = "Administrative"
}

variable "action_group_id" {
  type = string
}

variable "operation_name" {
  type = string
}

variable "label_operation_name" {
  type    = string
  default = "Delete"
}

variable "subscription_id" {
  type = string
}

variable "env_name" {
  type = string
}