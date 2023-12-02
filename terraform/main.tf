data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

locals {
  resources_owner = coalesce(var.resources_owner, data.azuread_client_config.current.object_id)
}

resource "azurerm_resource_group" "main" {
  name     = "core-lab"
  location = "West Europe"
}

module "aad_app" {
  source              = "./aad"
  aad_app_name        = "IAP personal"
  aad_resources_owner = local.resources_owner
  aad_app_redirect_uris = [
    "https://${var.auth_root}/oauth2/callback"
  ]
  aad_app_identifier_uris = [
    "api://${var.auth_root}"
  ]
}

resource "azuread_group" "private" {
  display_name     = "private"
  owners           = [local.resources_owner]
  security_enabled = true
}

resource "azuread_group" "labs" {
  display_name     = "labs"
  owners           = [local.resources_owner]
  security_enabled = true
}
