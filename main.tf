# Create a new SSH key
resource "tls_private_key" "provisionkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "digitalocean_ssh_key" "sshpublickeys" {
    count = length(var.sshpublickeys)
    name = "sshpublickey_${count.index}"
    public_key = "${var.sshpublickeys[count.index]}"
}

resource "digitalocean_ssh_key" "provisionkey" {
  name       = "provisionkey"
  public_key = "${tls_private_key.provisionkey.public_key_openssh}"
}

resource "digitalocean_droplet" "wireguard" {
  ipv6 = true
  image  = var.droplet_image
  name   = "wireguard"
  region = var.droplet_region
  size   = var.droplet_size
  ssh_keys = concat([digitalocean_ssh_key.provisionkey.id], digitalocean_ssh_key.sshpublickeys[*].id)
  user_data = data.template_cloudinit_config.userdata.rendered
}
