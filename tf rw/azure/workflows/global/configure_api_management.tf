# locals {
#   api_management_name     = "${var.env_prefix}-apim"
#   api_management_name_pep = "${var.env_prefix}-apim-pep"
# }

# resource "azurerm_api_management_api" "apim_api" {
#   name                = local.api_management_api_name
#   resource_group_name = local.rg_apim
#   api_management_name = local.api_management_name
#   revision            = "1"
#   display_name        = "Example API"
#   path                = "example"
#   protocols           = ["https"]

#   # import {
#   #   content_format = "swagger-link-json"
#   #   content_value  = "http://conferenceapi.azurewebsites.net/?format=json"
#   # }
# }

