resource "random_pet" "app" {
  length = 1
}

resource "azuread_application" "main" {
  display_name = "${var.app_name}-${random_pet.app.id}"

  web {
    redirect_uris = var.app_redirect_uris
  }

  api {
    requested_access_token_version = 2
    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
      admin_consent_display_name = "Access example"
      id                         = "98830695-27a2-44f7-8c18-0c3ebc9698f6" # GroupMember.Read.All
      type                       = "Admin"
      enabled                    = true
      value                      = "administer"
    }
    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access example on behalf of the signed-in user."
      admin_consent_display_name = "Access example"
      id                         = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # GroupMember.Read.All
      type                       = "Admin"
      enabled                    = true
      value                      = "user-read"
    }
  }

  group_membership_claims = [
    "All"
  ]

  optional_claims {
    access_token {
      name = "groups"
    }

    id_token {
      name = "groups"
    }

    saml2_token {
      name = "groups"
    }
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

    resource_access {
      id   = "98830695-27a2-44f7-8c18-0c3ebc9698f6" # GroupMember.Read.All
      type = "Role"
    }
    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

  identifier_uris = var.app_identifier_uris

  prevent_duplicate_names = true
  sign_in_audience        = "AzureADMyOrg"
  owners                  = var.app_owners
}

resource "azuread_service_principal" "main" {
  application_id = azuread_application.main.application_id
  owners         = [data.azuread_client_config.current.object_id]
}

resource "azuread_directory_role" "cloud_application_administrator" {
  template_id = "158c047a-c907-4556-b7ef-446551a6b5f7" # Cloud Application Administrator
}


resource "azurerm_role_definition" "main" {
  name        = "${var.app_name}-role"
  scope       = data.azurerm_subscription.primary.id
  description = "This is role for App registrations used for ${var.app_name}."

  permissions {
    actions = [
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.Compute/virtualMachineScaleSets/*/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id,
  ]
}

resource "azurerm_role_assignment" "main" {
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.main.role_definition_resource_id
  principal_id       = azuread_service_principal.main.object_id
}

resource "azuread_application_password" "main" {
  display_name          = var.app_name
  application_object_id = azuread_application.main.object_id
}
