# main.tf

provider "azurerm" {
  features {}
  # Add your Azure provider configuration here
}

# Create the subscription
resource "azurerm_subscription" "subscription" {
  name              = var.subscription_name
  billing_scope_id  = var.billing_account_id
  management_group_id = var.management_group_id
}

# Apply policies as needed
resource "azurerm_policy_assignment" "policy" {
  name               = "policy-assignment"
  scope              = azurerm_subscription.new_subscription.id
  policy_definition_id = var.policy_definition_id 
}

# Apply RBAC roles as needed
resource "azurerm_role_assignment" "role" {
  scope                = azurerm_subscription.new_subscription.id
  role_definition_name = "Contributor"
  principal_id         = var.principal_id
}
