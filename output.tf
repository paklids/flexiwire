output "ip" {
  value = digitalocean_droplet.wireguard.ipv4_address
}

output "ipv6" {
  value = digitalocean_droplet.wireguard.ipv6_address
}