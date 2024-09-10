terraform {
  required_version = ">= 0.14"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.89.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.2"
    }
  }

  backend "azurerm" {}
}
