variable "aad_resources_owner" {
  type        = string
  description = "AAD resources owner"
}

variable "aad_app_owners" {
  type        = list(string)
  default     = null
  description = "A set of object IDs of principals that will be granted ownership of the application."
}

variable "aad_app_name" {
  type        = string
  description = "app name"
}

variable "aad_app_redirect_uris" {
  type        = list(string)
  description = "App redirect URI(s)"
}

variable "aad_app_identifier_uris" {
  type        = list(string)
  description = "App redirect URI(s)"
  default     = [""]
}
