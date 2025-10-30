##-----------------------------------------------------------------------------
## Permissions, Roles, and Policies
##-----------------------------------------------------------------------------
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

#-------------------------------
# Application Roles
# -------------------------------
resource "azuread_application_app_role" "reader" {
  application_id       = azuread_application.sp.id
  allowed_member_types = ["User", "Application"]
  description          = "Read-only access to the application."
  display_name         = "Reader"
  value                = "Reader"
  role_id              = uuid()
}

resource "azuread_application_app_role" "admin" {
  application_id       = azuread_application.sp.id
  allowed_member_types = ["User", "Application"]
  description          = "Full administrative access to the application."
  display_name         = "Admin"
  value                = "Admin"
  role_id              = uuid()
}

# -------------------------------
# Assign App Roles to the SP
# -------------------------------
resource "azuread_app_role_assignment" "assign_roles" {
  for_each = {
    reader = azuread_application_app_role.reader.role_id
    admin  = azuread_application_app_role.admin.role_id
  }

  app_role_id         = each.value
  principal_object_id = azuread_service_principal.sp.object_id
  resource_object_id  = azuread_service_principal.sp.object_id

  depends_on = [
    azuread_service_principal.sp,
    azuread_application_app_role.reader,
    azuread_application_app_role.admin
  ]
}

resource "azurerm_role_assignment" "sp_contributor" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.sp.object_id
}
