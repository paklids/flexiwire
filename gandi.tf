
provider "gandi" {
    key = var.gandiKey
    sharing_id = var.gandiSharingId
}

variable "gandiKey" {}
variable "gandiSharingId" {}
variable "domainName" {
  type        = string
  description = "domain name"
  default     = "mydomain"
}

variable "hostname" {
  type        = string
  description = "hostname"
  default     = "myhostname"
}

data "gandi_domain" "mydomain" {
  name = var.domainName
}

resource "gandi_livedns_record" "hostA" {
  zone = "${data.gandi_domain.mydomain.id}"
  name = var.hostname
  type = "A"
  ttl = 300
  values = [
    "${digitalocean_droplet.wireguard.ipv4_address}"
  ]
}

resource "gandi_livedns_record" "hostAAAA" {
  zone = "${data.gandi_domain.mydomain.id}"
  name = var.hostname
  type = "AAAA"
  ttl = 300
  values = [
    "${digitalocean_droplet.wireguard.ipv6_address}"
  ]
}