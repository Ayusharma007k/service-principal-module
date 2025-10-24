##-----------------------------------------------------------------------------
## Variables
##-----------------------------------------------------------------------------
variable "app_name" {
  description = "The name of the Azure AD Application"
  type        = string
  default     = "my-app-registration"
}

variable "sp_password_value" {
  description = "Password for the Service Principal"
  type        = string
  default     = "ChangeMe123!"
  sensitive   = true
}

variable "owner_object_id" {
  description = "Object ID of the owner (user or service principal)"
  type        = string
  default     = ""
}
variable "subscription_id" {
  type        = string
  description = "Azure subscription ID for role assignment"
}
variable "secret_map" {
  description = "Map of secret names to expiry times (Terraform duration format)"
  type        = map(string)
}
variable "enable_api_permission" {
  description = "Whether to enable Microsoft Graph API permissions (User.Read, Email, Profile, OpenID)"
  type        = bool
  default     = true
}
variable "enable_token_config" {
  type        = bool
  description = "Enable token configuration for the application"
  default     = true
}
variable "redirect_uris" {
  type        = list(string)
  description = "List of web redirect URIs for the Azure AD Application"
  default     = ["https://localhost/"]
}

variable "front_channel_logout_urls" {
  type        = list(string)
  description = "List of front-channel logout URLs"
  default     = ["https://localhost/logout"]
}
