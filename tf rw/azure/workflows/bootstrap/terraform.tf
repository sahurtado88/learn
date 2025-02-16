terraform {
  required_version = ">= 0.14"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.89.0"
    }
    harness = {
      source  = "harness/harness"
      version = "0.14.2"
    }
  }
  backend "azurerm" {}
}
