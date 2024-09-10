module "api_management" {
  source                         = "../../modules/api_management"
  rg_name                        = local.rg_apim
  location                       = var.location
  api_management_name            = local.api_management_name
  api_management_publisher_name  = var.api_management_publisher_name
  api_management_publisher_email = var.api_management_publisher_email
  api_management_sku_name        = var.api_management_sku_name

  depends_on = [
    module.apim_rg
  ]

}





