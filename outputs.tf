##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------

# Service Principal ID
output "service_principal_id" {
  value       = azuread_service_principal.sp.id
  description = "The ID of the created Service Principal"
}

# Service Principal Client ID (App ID)
output "service_principal_client_id" {
  value       = azuread_service_principal.sp.client_id
  description = "The Client ID (App ID) of the Service Principal"
}

# Combined map of secret ID and value (displayed in console)
output "service_principal_secrets" {
  value = {
    for name, secret in azuread_application_password.sp_secrets :
    name => {
      id    = secret.id
      value = secret.value
    }
  }
  sensitive   = true   # <--- Remove sensitivity to show values in console
  description = "Map of secret names to their ID and value"
}
