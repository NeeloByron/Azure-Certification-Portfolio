# Azure Custom RBAC Roles
## Prerequisites
- Azure CLI or Az PowerShell module installed.
- Permissions to create custom roles (**Owner** or **User Access Administrator**) at the subscription level.
- Replace placeholders in JSON files (subscription IDs) and scripts (object IDs, resource group names) with your actual values.

## Structure

- **VM-Operator/** – Custom role for starting/stopping VMs (no create/delete).
  - `role-definition.json` – The role definition.
  - `create-role.ps1` – PowerShell script to create the role.
  - `create-role.sh` – Azure CLI script to create the role.
  - `assign-role.sh` – Example assignment script (CLI).

## Usage

1. Edit the `role-definition.json` to set the correct `AssignableScopes` (your subscription ID).
2. Run the creation script (PowerShell or CLI) to register the custom role in Azure.
3. Use the assignment script (or modify it) to grant the role to a user/group at a specific scope (subscription, resource group, or resource).

## Notes

- Custom roles are stored in Azure AD and are visible in the portal under "Subscriptions" → your subscription → "Access control (IAM)" → "Roles".

## More Examples

Feel free to extend this folder with additional roles, such as:
- Storage Account Contributor with limited permissions
- Network Contributor restricted to a single VNet
- Custom roles with data actions (e.g., read blob data)
