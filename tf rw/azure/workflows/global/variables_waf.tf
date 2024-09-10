variable "whitelist_ip_range" {
  default = [
    # Global only
    "52.177.237.183/32", # ftvault-sandbox (gitlab access)
    "20.75.35.157/32",   # ftvault-nonprod (gitlab access)
    "52.253.65.226/32",  # ftvault-demo (gitlab access)
    "20.75.111.15/32",   # ftvault-production (gitlab access)
    "20.122.243.74/32"   # ftvault-preprod (gitlab access)
  ]
}
variable "waf_policy_enabled" {
  default = "true"
}
variable "waf_policy_mode" {
  default = "Prevention"
}
variable "waf_policy_request_body_check" {
  default = "true"
}
variable "waf_policy_file_upload_limit" {
  default = 300
}
variable "waf_policy_max_request_body_size" {
  default = 2000
}
variable "waf_manage" {
  default = true
}
variable "rule_group_override" {
  type = list(object({
    rule_group_name = string
    disabled_rules  = list(string)
  }))
  default = [
    {
      rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
      disabled_rules  = ["920300", "920420"]
    }
  ]
}

# REQUEST-911-METHOD-ENFORCEMENT
# REQUEST-913-SCANNER-DETECTION
# REQUEST-920-PROTOCOL-ENFORCEMENT
# REQUEST-921-PROTOCOL-ATTACK
# REQUEST-930-APPLICATION-ATTACK-LFI
# REQUEST-931-APPLICATION-ATTACK-RFI
# REQUEST-932-APPLICATION-ATTACK-RCE
# REQUEST-933-APPLICATION-ATTACK-PHP
# REQUEST-941-APPLICATION-ATTACK-XSS
# REQUEST-942-APPLICATION-ATTACK-SQLI
# REQUEST-943-APPLICATION-ATTACK-SESSION-FIXATION
# REQUEST-944-APPLICATION-ATTACK-JAVA

variable "rule_group_grafana_override" {
  type = list(object({
    rule_group_name = string
    disabled_rules  = list(string)
  }))
  default = []
}
variable "waf_grafana_manage" {
  default = true
}

# TODO: https://rockwellautomation.atlassian.net/browse/RAIDVRTSI-1522
variable "montoolsKey" {
  sensitive = true
  type      = string

  validation {
    condition     = length(var.montoolsKey) >= 48
    error_message = "The montoolsKey must be at least 48 chars long"
  }
}
