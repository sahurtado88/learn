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
      disabled_rules  = ["920230", "920300", "920320"]
    },
    {
      rule_group_name = "REQUEST-931-APPLICATION-ATTACK-RFI"
      disabled_rules  = ["931130"]
    },
    {
      rule_group_name = "REQUEST-932-APPLICATION-ATTACK-RCE"
      disabled_rules  = ["932130", "932115", "932140", "932150", "932110", "932100", "932105"]
    },
    {
      rule_group_name = "REQUEST-933-APPLICATION-ATTACK-PHP"
      disabled_rules  = ["933151", "933210", "933160"]
    },
    {
      rule_group_name = "REQUEST-941-APPLICATION-ATTACK-XSS"
      disabled_rules  = ["941150", "941160", "941310", "941330", "941340", "941350", "941100", "941180", "941320"]
    },
    {
      rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
      disabled_rules  = ["942110", "942190", "942260", "942300", "942330", "942340", "942370", "942430", "942440", "942200", "942130", "942410", "942150", "942450", "942120", "942360", "942100", "942180", "942310", "942350", "942380", "942390", "942400", "942480", "942210"]
    },
    {
      rule_group_name = "REQUEST-944-APPLICATION-ATTACK-JAVA"
      disabled_rules  = ["944110", "944250"]
    }
  ]
}

variable "rule_group_grafana_override" {
  type = list(object({
    rule_group_name = string
    disabled_rules  = list(string)
  }))
  default = []
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

variable "waf_grafana_manage" {
  default = true
}

variable "montoolsKey" {
  sensitive = true
  type      = string

  validation {
    condition     = length(var.montoolsKey) >= 48
    error_message = "The montoolsKey must be at least 48 chars long"
  }
}
