data "azurerm_subscription" "primary" {}
data "azurerm_function_app_host_keys" "deployment_function" {
  name                = local.function_app_name
  resource_group_name = local.rg_global
}
# data "azurerm_linux_function_app" "deployment_function" {
#   name                = local.function_app_name
#   resource_group_name = local.rg_global
# }

resource "time_offset" "expiry_period" {
  offset_days = var.secret_expiry_period
}

module "keyvault_secret_provider_ap" {
  count                       = var.key_vault_manage ? 1 : 0
  source                      = "../../modules/keyvault_access_policy"
  keyvault_tenant_id          = data.azurerm_key_vault.akv.tenant_id
  keyvault_id                 = data.azurerm_key_vault.akv.id
  keyvault_object_id          = module.aks.keyvault_secret_identity.object_id
  keyvault_cert_permissions   = var.key_vault_secret_provider_cert_permissions
  keyvault_key_permissions    = var.key_vault_secret_provider_key_permissions
  keyvault_secret_permissions = var.key_vault_secret_provider_secret_permissions
}

module "racertpod_identity" {
  count                 = var.key_vault_manage ? 1 : 0
  source                = "../../modules/managed_identity"
  rg_name               = local.rg_general
  location              = var.location
  managed_identity_name = var.racertpod_identity_name
}

module "keyvault_racertpod_identity_ap" {
  count                       = var.key_vault_manage ? 1 : 0
  source                      = "../../modules/keyvault_access_policy"
  keyvault_tenant_id          = data.azurerm_key_vault.akv.tenant_id
  keyvault_id                 = data.azurerm_key_vault.akv.id
  keyvault_object_id          = module.racertpod_identity[count.index].principal_id
  keyvault_cert_permissions   = var.key_vault_racertpod_cert_permissions
  keyvault_key_permissions    = var.key_vault_racertpod_key_permissions
  keyvault_secret_permissions = var.key_vault_racertpod_secret_permissions
}
resource "azurerm_key_vault_secret" "fthubauth0token" {
  count           = var.manage_ftbridge && var.key_vault_manage ? 1 : 0
  name            = var.fthubauth0token_name
  value           = "{}"
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}

resource "azurerm_key_vault_secret" "fthubclientsecret" {
  count           = var.manage_ftbridge && var.key_vault_manage ? 1 : 0
  name            = var.fthubclientsecret_name
  value           = var.fthub_client_secret
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}

resource "azurerm_key_vault_secret" "ftvaultclientid" {
  count           = var.manage_ftvault && var.key_vault_manage ? 1 : 0
  name            = var.ftvaultclientsecret_id
  value           = var.ftvault_client_id
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}
resource "azurerm_key_vault_secret" "ftvaultauth0token" {
  count           = var.manage_ftvault && var.key_vault_manage ? 1 : 0
  name            = var.ftvaultauth0token_name
  value           = "{}"
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}

resource "azurerm_key_vault_secret" "ftvaultclientsecret" {
  count           = var.manage_ftvault && var.key_vault_manage ? 1 : 0
  name            = var.ftvaultclientsecret_name
  value           = var.ftvault_client_secret
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}

resource "azurerm_key_vault_secret" "fthubclientid" {
  count           = var.manage_ftbridge && var.key_vault_manage ? 1 : 0
  name            = var.fthubclientsecret_id
  value           = var.fthub_client_id
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}

resource "azurerm_key_vault_secret" "ftraclientid" {
  count           = var.manage_ftra && var.key_vault_manage ? 1 : 0
  name            = var.ftraclientsecret_id
  value           = var.ftra_client_id
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}
resource "azurerm_key_vault_secret" "ftraauth0token" {
  count           = var.manage_ftra && var.key_vault_manage ? 1 : 0
  name            = var.ftraauth0token_name
  value           = "{}"
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}

resource "azurerm_key_vault_secret" "ftraclientsecret" {
  count           = var.manage_ftra && var.key_vault_manage ? 1 : 0
  name            = var.ftraclientsecret_name
  value           = var.ftra_client_secret
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}

resource "azurerm_key_vault_secret" "deploymentfunctionendpoint" {
  count = var.manage_ftbridge && var.key_vault_manage ? 1 : 0
  name  = var.deployment_function_endpoint
  # value        = data.azurerm_linux_function_app.deployment_function.site_config[0].api_definition_url
  value           = local.function_endpoint
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}
resource "azurerm_key_vault_secret" "deploymentfunctionapikey" {
  count           = var.manage_ftbridge && var.key_vault_manage ? 1 : 0
  name            = var.deployment_function_api_key
  value           = data.azurerm_function_app_host_keys.deployment_function.default_function_key
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
}
resource "azurerm_role_assignment" "managed_identity_operator" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = module.racertpod_identity[0].principal_id
}

resource "azurerm_key_vault_certificate" "domaincert" {
  count        = var.key_vault_manage ? 1 : 0
  name         = "${replace(var.dns_name_prefix, ".", "-")}-cert"
  key_vault_id = data.azurerm_key_vault.akv.id

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "EmailContacts"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      # Server Authentication = 1.3.6.1.5.5.7.3.1
      # Client Authentication = 1.3.6.1.5.5.7.3.2
      extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      # subject_alternative_names {
      #   dns_names = ["internal.contoso.com", "domain.hello.world"]
      # }

      subject            = "CN=*.${var.dns_name_prefix}.${var.raider_domain_name}"
      validity_in_months = var.raider_domain_cert_validity
    }
  }
  lifecycle {
    ignore_changes = [
      certificate_policy
    ]
  }
}

# resource "azurerm_key_vault_certificate" "privatedomaincert" {
#   count        = var.key_vault_manage ? 1 : 0
#   name         = "ftds-private-cert"
#   key_vault_id = data.azurerm_key_vault.akv.id

#   certificate_policy {
#     issuer_parameters {
#       name = "Self"
#     }

#     key_properties {
#       exportable = true
#       key_size   = 2048
#       key_type   = "RSA"
#       reuse_key  = true
#     }

#     lifetime_action {
#       action {
#         action_type = "EmailContacts"
#       }

#       trigger {
#         days_before_expiry = 30
#       }
#     }

#     secret_properties {
#       content_type = "application/x-pkcs12"
#     }

#     x509_certificate_properties {
#       # Server Authentication = 1.3.6.1.5.5.7.3.1
#       # Client Authentication = 1.3.6.1.5.5.7.3.2
#       extended_key_usage = ["1.3.6.1.5.5.7.3.1"]

#       key_usage = [
#         "cRLSign",
#         "dataEncipherment",
#         "digitalSignature",
#         "keyAgreement",
#         "keyCertSign",
#         "keyEncipherment",
#       ]

#       # subject_alternative_names {
#       #   dns_names = ["internal.contoso.com", "domain.hello.world"]
#       # }

#       subject            = "CN=*.${var.private_dns_name}"
#       validity_in_months = var.raider_domain_cert_validity
#     }
#   }
#   lifecycle {
#     ignore_changes = [
#       certificate_policy
#     ]
#   }
# }

