terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tf"
    storage_account_name = "eaitfstate"
    container_name       = "lab"
    key                  = "core.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  features {}
}

provider "cloudflare" {
  api_token = var.dns_cf_token
}
