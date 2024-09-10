variable "env_prefix" {
  type = string
}

variable "alert_name_suffix" {
  type    = string
  default = "Policy Rules"
}

# variable "policy_assignment_rg" {}

variable "category" {
  type    = string
  default = "Administrative"
}

variable "env_name" {
  type = string
}

variable "operation_name_pa" {
  type    = string
  default = "Microsoft.Authorization/policyAssignments/write"
}

variable "operation_name_nsg" {
  type    = string
  default = "Microsoft.Network/networkSecurityGroups/write"
}

variable "operation_name_sec_grp_rule" {
  type    = string
  default = "Microsoft.Network/networkSecurityGroups/securityRules/write"
}

variable "operation_name_sec_soln" {
  type    = string
  default = "Microsoft.Security/securitySolutions/write"
}

variable "alerts_manage" {
  type = bool
}