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
variable "secret_names" {
  description = "List of secret names to create for the app."
  type        = list(string)
  default     = ["secret1", "secret2", "secret3"]
}