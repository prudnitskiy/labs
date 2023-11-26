variable "app_owners" {
  type        = list(string)
  default     = null
  description = "A set of object IDs of principals that will be granted ownership of the application."
}

variable app_name {
  type        = string
  description = "app name"
}

variable app_redirect_uris {
    type = list(string)
    description = "App redirect URI(s)"
}

variable app_identifier_uris {
    type = list(string)
    description = "App redirect URI(s)"
    default = [""]
}
