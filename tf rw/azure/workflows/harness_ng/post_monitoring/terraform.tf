terraform {
  required_version = ">= 0.14"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.89.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.30.0"
    }

    harness = {
      source  = "harness/harness"
      version = "0.29.4"
    }
  }

  backend "azurerm" {}
}
