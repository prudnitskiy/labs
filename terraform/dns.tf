locals {
    lab_hosts = {
        "auth" = {},
        "mon" = {},
        "ki" = {},
        "cedar" = {
            host = "143.47.176.105",
            proxied = false
        }
        "catfish" = {
            host = "95.216.35.8"
            proxied = false
        }
    }
}

resource "cloudflare_zone" "main" {
    account_id = var.dns_cf_account
    zone       = "prudnitskiy.pro"
}

resource "cloudflare_record" "this" {
    for_each = local.lab_hosts
    zone_id  = cloudflare_zone.main.id
    name     = each.key
    value    = sensitive(try(each.value.host, var.dns_root_host))
    type     = "A"
    proxied  = try(each.value.proxied, true)
}
