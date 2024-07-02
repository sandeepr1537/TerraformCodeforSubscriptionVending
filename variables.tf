# variables.tf


variable "tenant_id" {
  description = "The tenant ID of the Azure AD tenant"
  type        = string
}

variable "user_principal_name" {
  description = "The UPN of the user in Azure AD"
  type        = string
}

variable "subscription_id" {
  description = "Subscription ID where the resources will be provisioned"
  type        = string
}
