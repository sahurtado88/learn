locals {
  montools_key_harness_secret    = "${var.env_prefix}-${var.env_name}-montools-key"
  montools_key_harness_secret_id = "${var.env_prefix}${title(var.env_name)}MontoolsKey"
}

##
# Configure WAF
##

# confirmed via experiment: repeaded invocation preserves the original value
resource "random_password" "montoolsKey" {
  length  = 48
  special = false
}

resource "harness_platform_secret_text" "montoolsKey" {
  identifier                = local.montools_key_harness_secret_id
  name                      = local.montools_key_harness_secret
  value                     = random_password.montoolsKey.result
  value_type                = "Inline"
  secret_manager_identifier = var.harness_secret_manager_identifier
}
