output "application_id" {
  value       = module.aad_app.application_id
  sensitive   = true
  description = "Application ID of Azure AD application."
}

output "client_secret" {
  value       = module.aad_app.client_secret
  sensitive   = true
  description = "Client secret of Azure AD application."
}

output "tenant_id" {
  value       = module.aad_app.tenant_id
  description = "Tenant ID of Azure subscription."
}

output "private_grp_id" {
  value = azuread_group.private.id
  description = "Private group ID"
}
