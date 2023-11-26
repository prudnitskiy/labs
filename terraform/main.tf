data "azurerm_client_config" "current" {}
data "azuread_client_config" "current" {}

resource "azurerm_resource_group" "main" {
  name     = "core-lab"
  location = "West Europe"
}

module "aad_app" {
  source            = "./aad"
  app_name          = "IAP personal"
  app_redirect_uris = [
    "https://${var.auth_root}/oauth2/callback"
  ]
  app_identifier_uris = [
    "api://${var.auth_root}"
  ]
}

resource "azuread_group" "private" {
  display_name     = "private"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}

resource "azuread_group" "labs" {
  display_name     = "labs"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}
