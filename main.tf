# -------------------------------
# Azure AD Application
# -------------------------------
resource "azuread_application" "sp" {
  count        = var.enable ? 1 : 0
  display_name = var.app_name
  owners       = [var.owner_object_id]

  # Single web block with all redirect URIs
  web {
    redirect_uris = var.redirect_uris
    # Only one logout URL is allowed
    logout_url = length(var.front_channel_logout_urls) > 0 ? var.front_channel_logout_urls[0] : null
  }

  # API Permissions
  dynamic "required_resource_access" {
    for_each = var.enable_api_permission ? [1] : []
    content {
      resource_app_id = "00000003-0000-0000-c000-000000000000"

      dynamic "resource_access" {
        for_each = var.api_permissions
        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }
}

# -------------------------------
# Service Principal
# -------------------------------
resource "azuread_service_principal" "sp" {
  count                        = var.enable ? 1 : 0
  client_id                    = azuread_application.sp[0].client_id
  app_role_assignment_required = false
  owners                       = [var.owner_object_id]
}

# -------------------------------
# Secrets
# -------------------------------
resource "azuread_application_password" "sp_secrets" {
  for_each = var.enable ? var.secret_map : {}

  application_id = azuread_application.sp[0].id
  display_name   = each.key
  end_date       = timeadd(timestamp(), each.value)
}