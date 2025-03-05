# Azure AD Administrative Unit Terraform Module

## Overview

This Terraform module creates and manages an Azure Active Directory (Entra ID) Administrative Unit with flexible configuration options for members and role assignments.

## Features

- Create an Administrative Unit with customizable display name and description
- Add members using:
  - User Principal Names (UPNs)
  - Direct Object IDs
- Assign directory roles scoped to the Administrative Unit
- Configurable visibility settings

## Requirements

- Terraform 1.3.0 or later
- AzureAD Provider 2.30.0 or later

## Usage Example

```hcl
module "admin_unit" {
  source = "./path/to/module"

  display_name = "IT Support Team"
  description  = "Administrative unit for IT support personnel"
  visibility   = "Public"

  user_principal_names = [
    "user1@example.com",
    "user2@example.com"
  ]

  member_object_ids = [
    "00000000-0000-0000-0000-000000000000"
  ]

  role_assignments = [
    {
      role_name           = "User Administrator"
      principal_object_id = "11111111-1111-1111-1111-111111111111"
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| display_name | Display name for the administrative unit | `string` | n/a | yes |
| description | Description for the administrative unit | `string` | `"Administrative Unit for managing delegated resources"` | no |
| visibility | Visibility of the administrative unit (Public or HiddenMembership) | `string` | `"Public"` | no |
| user_principal_names | List of user principal names to add as members | `list(string)` | `null` | no |
| member_object_ids | List of object IDs to add as members | `list(string)` | `null` | no |
| role_assignments | List of role assignments within the administrative unit | `list(object)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The object ID of the administrative unit |
| display_name | The display name of the administrative unit |
| object_id | The object ID of the administrative unit |

## Notes

- Ensure you have the necessary permissions to create Administrative Units and manage role assignments in Azure AD
- The module supports adding members and assigning roles flexibly

