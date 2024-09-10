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

resource "azurerm_key_vault_certificate" "privatedomaincert" {
  count        = var.key_vault_manage ? 1 : 0
  name         = "ftds-private-cert"
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

      subject            = "CN=*.${var.private_dns_name}"
      validity_in_months = var.raider_domain_cert_validity
    }
  }
  lifecycle {
    ignore_changes = [
      certificate_policy
    ]
  }
}

resource "time_offset" "expiry_period" {
  offset_days = var.secret_expiry_period
}
resource "azurerm_key_vault_secret" "globalsaconstr" {
  count           = var.key_vault_manage ? 1 : 0
  name            = var.global_sa_constr_secret
  value           = module.global_storage_account.primary_connection_string
  key_vault_id    = data.azurerm_key_vault.akv.id
  expiration_date = time_offset.expiry_period.rfc3339
  depends_on = [
    module.global_storage_account
  ]
}
