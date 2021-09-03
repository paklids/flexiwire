output "ip" {
  value = digitalocean_droplet.wireguard.ipv4_address
}