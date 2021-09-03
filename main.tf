resource "digitalocean_droplet" "wireguard" {
  image  = var.droplet_image
  name   = "wireguard"
  region = var.droplet_region
  size   = var.droplet_size
  ssh_keys = [
    var.ssh_key_fingerprint
  ]
  user_data = data.template_cloudinit_config.userdata.rendered

  provisioner "local-exec" {
    command = "curl --basic -s -u \"${var.dynu_credentials}\" \"https://api.dynu.com/nic/update?hostname=${var.dynu_domain}&myip=${self.ipv4_address}\""
  }
}
