# Create a new Entra ID Administrative Unit
resource "azuread_administrative_unit" "this" {
  display_name = var.display_name
  description  = var.description
  visibility   = var.visibility
}

# Look up users by their UPNs if provided
data "azuread_user" "users" {
  for_each            = var.user_principal_names != null ? toset(var.user_principal_names) : toset([])
  user_principal_name = each.value
}

# Add users to the Administrative Unit
resource "azuread_administrative_unit_member" "users" {
  for_each                = data.azuread_user.users
  administrative_unit_id  = azuread_administrative_unit.this.id
  member_object_id        = each.value.object_id
}

# Add explicit object IDs to the Administrative Unit
resource "azuread_administrative_unit_member" "explicit" {
  for_each                = var.member_object_ids != null ? toset(var.member_object_ids) : toset([])
  administrative_unit_id  = azuread_administrative_unit.this.id
  member_object_id        = each.value
}

# Lookup role definitions if provided by name
data "azuread_directory_role" "roles" {
  for_each     = var.role_assignments != null ? { for assignment in var.role_assignments : assignment.role_name => assignment
  } : {}
  display_name = each.value.role_name
}

# Add role assignments within the Administrative Unit scope
resource "azuread_directory_role_assignment" "au_scoped" {
  for_each              = var.role_assignments != null ? { for assignment in var.role_assignments :
"${assignment.role_name}_${assignment.principal_object_id}" => assignment } : {}
  role_id               = data.azuread_directory_role.roles[each.value.role_name].id
  principal_object_id   = each.value.principal_object_id
  directory_scope_id    = "/administrativeUnits/${azuread_administrative_unit.this.id}"
}