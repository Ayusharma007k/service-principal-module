#-----------------------------------------------------------------------------
# Outputs
#-----------------------------------------------------------------------------

# Service Principal ID
output "service_principal_id" {
  description = "The ID (object ID) of the created Service Principal"
  value       = var.enable ? azuread_service_principal.sp[0].id : null
}

# Service Principal Client ID (App ID)
output "service_principal_client_id" {
  description = "The Client ID (App ID) of the Service Principal"
  value       = var.enable ? azuread_service_principal.sp[0].client_id : null
}

output "service_principal_display_name" {
  description = "The display name of the Service Principal"
  value       = var.enable ? azuread_service_principal.sp[0].display_name : null
}

output "application_id" {
  description = "The application (client) ID"
  value       = var.enable ? azuread_application.sp[0].client_id : null
}

output "application_object_id" {
  description = "The object ID of the Azure AD Application"
  value       = var.enable ? azuread_application.sp[0].id : null
}

# Combined map of secret ID and value
output "service_principal_secrets" {
  description = "Map of secret names to their ID and value"
  value = var.enable ? {
    for name, secret in azuread_application_password.sp_secrets :
    name => {
      id    = secret.id
      value = secret.value
    }
  } : {}
  sensitive = true
}
