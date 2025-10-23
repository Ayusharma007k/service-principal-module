provider "azurerm" {
  features {}
  subscription_id = "1ac2caa4-336e-4daa-b8f1-0fbabe2d4b11"
}

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

  secret_names = ["secret1", "secret2", "secret3"]
}
