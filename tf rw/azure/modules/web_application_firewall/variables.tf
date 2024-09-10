variable "whitelist_ip_range" {}
variable "waf_policy_rg_name" {}
variable "location" {}
variable "fw_policy_name" {
  default = "appgtway-wafp-preview"
}
variable "waf_policy_enabled" {
  default = "True"
}
variable "waf_policy_mode" {
  default = "Prevention"
}
variable "waf_policy_request_body_check" {
  default = "True"
}
variable "waf_policy_file_upload_limit" {
  default = 300
}
variable "waf_policy_max_request_body_size" {
  default = 2000
}
variable "block_all_ip_range" {
  default = ["0.0.0.0/1", "128.0.0.0/1"]
}
variable "custom_rules_monitoring" {
  default = false
}
variable "custom_rules_whitelist" {
  default = true
}
variable "exclusion" {
  type = list(object({
    match_variable          = string
    selector                = string
    selector_match_operator = string
  }))
  default = [{
    match_variable          = "RequestHeaderNames"
    selector                = "application/x-git-upload-pack-request"
    selector_match_operator = "Equals"
    },
    {
      match_variable          = "RequestHeaderNames"
      selector                = "application/x-git-receive-pack-request"
      selector_match_operator = "Equals"
  }]
}
variable "managed_rule_set_type" {
  default = "OWASP"
}
variable "managed_rule_set_version" {
  default = "3.2"
}
variable "rule_group_override" {
  type = list(object({
    rule_group_name = string
    disabled_rules  = list(string)
  }))
  default = [{
    rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
    disabled_rules  = [""]
  }]
}
variable "montoolsKey" {
  sensitive = true
  type      = string

  validation {
    condition     = length(var.montoolsKey) >= 48
    error_message = "The montoolsKey must be at least 48 chars long"
  }
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

variable "custom_rules_geolocation" {
  default = false
}

# https://learn.microsoft.com/en-us/azure/web-application-firewall/afds/waf-front-door-geo-filtering#countryregion-code-reference
variable "block_countries" {
  default = ["SY", "CU", "IR", "KP", "BY", "RU"]
}

# SY	Syrian Arab Republic
# CU	Cuba
# IR	Iran, Islamic Republic of
# KP	Korea, Democratic People's Republic of
# BY	Belarus
# RU	Russian Federation
