#main.tf

provider "azurerm" {
  features {}
}

provider "azuread" {
  tenant_id = var.tenant_id
}

# Create Policy Definition
resource "azurerm_policy_definition" "example_policy" {
  name         = "example-policy"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Require Storage Account Encryption"
  description  = "This policy ensures that storage accounts have encryption enabled."

  policy_rule = <<POLICY
{
  "if": {
    "field": "type",
    "equals": "Microsoft.Storage/storageAccounts"
  },
  "then": {
    "effect": "deny"
  }
}
POLICY

  metadata = <<METADATA
{
  "category": "Storage"
}
METADATA
}

# Retrieve the Azure AD User Principal ID
data "azuread_user" "example_user" {
  user_principal_name = var.user_principal_name
}

# Apply Policy Assignment
resource "azurerm_policy_assignment" "example_policy_assignment" {
  name                 = "example-policy-assignment"
  scope                = var.subscription_id
  policy_definition_id = azurerm_policy_definition.example_policy.id
}

# Assign Role to Principal
resource "azurerm_role_assignment" "example_role_assignment" {
  scope                = var.subscription_id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_user.example_user.object_id
}

# Outputs
output "policy_definition_id" {
  value = azurerm_policy_definition.example_policy.id
}

output "principal_id" {
  value = data.azuread_user.example_user.object_id
}

output "assigned_policy_definition_id" {
  value = azurerm_policy_assignment.example_policy_assignment.policy_definition_id
}

output "role_assignment_principal_id" {
  value = azurerm_role_assignment.example_role_assignment.principal_id
}
