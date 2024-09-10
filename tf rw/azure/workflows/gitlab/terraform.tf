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
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.19.0"
    }
    harness = {
      source  = "harness/harness"
      version = "0.14.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.11.2"
    }
    # tfstate files needs to be updated
  }

  backend "azurerm" {}

}
