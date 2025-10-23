output "sp_service_principal_id" {
  value = module.service_principal.service_principal_id
}

output "sp_client_id" {
  value = module.service_principal.service_principal_client_id
}

output "sp_secrets" {
  value     = module.service_principal.service_principal_secrets
  sensitive = true   # to show values in console
}
