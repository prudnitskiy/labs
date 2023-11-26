variable dns_cf_token {
  type        = string
  description = "CF token"
}

variable dns_cf_account {
  type        = string
  description = "CF user account"
}

variable dns_root_host {
  type        = string
  description = "IP of root host"
}

variable auth_root {
  type        = string
  default     = "auth.prudnitskiy.pro"
  description = "auth root domain"
}
