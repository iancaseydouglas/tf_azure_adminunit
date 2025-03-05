variable "display_name" {
  type        = string
  description = "(Required) The display name for the administrative unit."
}

variable "description" {
  type        = string
  description = "(Optional) The description for the administrative unit."
  default     = "Administrative Unit for managing delegated resources"
}

variable "visibility" {
  type        = string
  description = "(Optional) The visibility of the administrative unit. Possible values are 'Public' or 'HiddenMembership'."
  default     = "Public"
  validation {
    condition     = contains(["Public", "HiddenMembership"], var.visibility)
    error_message = "The visibility must be either 'Public' or 'HiddenMembership'."
  }
}

variable "user_principal_names" {
  type        = list(string)
  description = "(Optional) A list of user principal names (UPNs) to add as members to the administrative unit."
  default     = null
}

variable "member_object_ids" {
  type        = list(string)
  description = "(Optional) A list of object IDs to add as members to the administrative unit."
  default     = null
}

variable "role_assignments" {
  type = list(object({
    role_name           = string
    principal_object_id = string
  }))
  description = "(Optional) A list of role assignments to create within the administrative unit scope."
  default     = null
}