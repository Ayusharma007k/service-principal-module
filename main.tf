# -------------------------------
# Azure AD Application
# -------------------------------
resource "azuread_application" "sp" {
  display_name = var.app_name
  owners       = [var.owner_object_id]

 # Single web block with all redirect URIs
  web {
    redirect_uris = var.redirect_uris

    # Only one logout URL is allowed
    logout_url = length(var.front_channel_logout_urls) > 0 ? var.front_channel_logout_urls[0] : null
  }

  dynamic "required_resource_access" {
    for_each = var.enable_api_permission ? [1] : []
    content {
      resource_app_id = "00000003-0000-0000-c000-000000000000"

      resource_access {
        id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
        type = "Scope"
      }

      resource_access {
        id   = "64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0" # Email
        type = "Scope"
      }

      resource_access {
        id   = "14dad69e-099b-42c9-810b-d002981feec1" # Profile
        type = "Scope"
      }

      resource_access {
        id   = "37f7f235-527c-4136-accd-4a02d197296e" # OpenID
        type = "Scope"
      }
    }
  }
}
# -------------------------------
# Service Principal
# -------------------------------
resource "azuread_service_principal" "sp" {
  client_id                    = azuread_application.sp.client_id
  app_role_assignment_required = false
  owners                       = [var.owner_object_id]
}

# -------------------------------
# Secrets
# -------------------------------
resource "azuread_application_password" "sp_secrets" {
  for_each = var.secret_map

  application_id = azuread_application.sp.id
  display_name   = each.key
  end_date       = timeadd(timestamp(), each.value)
}
