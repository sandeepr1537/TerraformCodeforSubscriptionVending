# variables.tf

variable "subscription_name" {
  description = "Name of the new subscription"
  type        = string
}

variable "management_group_id" {
  description = "ID of the management group where the subscription will be created"
  type        = string
}

variable "billing_account_id" {
  description = "ID of the billing account for the subscription"
  type        = string
}

variable "policy_definition_id" {
  description = "Policy Definition"
}

variable "principal_id" {
  description = "Principal ID"
  
}
