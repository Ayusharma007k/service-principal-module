# provider "azurerm" {
#   features {}
#   subscription_id = "1ac2caa4-336e-4daa-b8f1-0fbabe2d4b11"
# }

provider "azuread" {}

data "azuread_client_config" "current" {}

##-----------------------------------------------------------------------------
## Service Principal module call
##-----------------------------------------------------------------------------
module "service_principal" {
  source   = "../../"
  
  # Module variables
  app_name         = "my-sp"
  owner_object_id  = data.azuread_client_config.current.object_id
  subscription_id  = "1ac2caa4-336e-4daa-b8f1-0fbabe2d4b11"

   # Multiple redirect URIs are allowed
  redirect_uris = [
    "https://localhost/",
    "https://myapp.com/callback",
    "https://myapp.com/redirect"
  ]

  # Only the first logout URL is supported by azuread_application resource
  front_channel_logout_urls = [
    "https://localhost/logout"
  ]
  secret_map = {
    secret1 = "4380h"   # 6 months
    secret2 = "8760h"   # 1 year
    secret3 = "13140h"  # 1.5 years
  }
  enable_api_permission = true
  enable_token_config   = true
}
