#main.tf

# Define variables
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

# Create the subscription
resource "azurerm_subscription" "new_subscription" {
  name                = var.subscription_name
  billing_scope_id    = var.billing_account_id
  management_group_id = var.management_group_id
}

# Apply policies and RBAC roles as needed
resource "azurerm_policy_assignment" "example_policy" {
  name                 = "example-policy-assignment"
  scope                = azurerm_subscription.new_subscription.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/<policy_definition_id>"
}

resource "azurerm_role_assignment" "example_role" {
  scope              = azurerm_subscription.new_subscription.id
  role_definition_name = "Contributor"
  principal_id       = "<principal_id>"
}
