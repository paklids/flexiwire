# Create a new SSH key
resource "digitalocean_ssh_key" "t460ksshey" {
  name       = "t460"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZwj8q0UEqvsFyi6Apy/9dvpqToX+dkNiu32AFryON2Quvv7pwzaO1/PN0GRNN+yHcIkIxHYueWtTF8J+i+5XkwxY5LJqhoxbLaXuwt7RRpLmf0YFvJVjvRX+h0zGnKvKhxlezbINxyp74eN7dxoX/Vq1xkkk9vxQtlJaY5uR0hYrLW2bRrQZA4VHKuhmR+qeodHmDLggNLYrIGe9pfeBi5GSBM2m/XVDPAd1arSWYb0huMdIs5g6BH8MJwV6KBENaL/udWSI68fQtTUcPTtI3b0aq+Ixj5y1oKG5Em41bnTgeh5LMAXOfX8aZxQu2f1LJnRTV6DtYFWLb5OVPp/ux mathieur@s540"
}

resource "digitalocean_ssh_key" "biniousshkey" {
  name       = "biniou"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAyNScu+ypq3GLcGftRdftGXxG7vcRGlfq+ooIr4Fvj0Qbr6rPbV9caxUe6q+1NCdYwLS8Uu4kU6n7EmApXsyw7OO7kZtH86796cxvUbpKpJO0w5dyT9sMSXhNeP81QjnWjoFZ1i4fwkOPwGrfJKGUZ6gbdL4II6u+x8beNzoq7jxYRwCdmyfigDVDiEwtKoORqTeWsrLdWUD1GYtwdnNCnHQsqVHMfvEpM39yMDrqyKs/3/qEBe/lPG3thV9omItM6xVuOJld0YLqAiuxminO1cnngYSEoEdOdITbsTh0GTluRmhOimrAqCBKx82oUy22iYP8UXVT+ZfklDp55tQOcw== mathieu@biniou"
}

resource "digitalocean_ssh_key" "myscriptsshkey" {
  name       = "myscript"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkIbsDmpxghluE+jy48dVOsE1MEfIJH+z211+u0re9HXrwIEFXbCNQAnRcupEh4BctQjqWtTFqDmM1A0+AV5Kg0vCZZhDbCoAHg03wtL0zdZms7iE7ukGwIpNNKvLR5vLnck4H05XLEUXhHhEFZzEvgEOh15qsII0cX3xnMdM9nAuqRnZjCvmL8a77/7VTDY7IywpMVSBBga9XZwc/x3TcHdXGuxzX8HoTAHE8MjqCTwBPGK8H1tmxFzg+si+JRSNzY6h6KD0VgH1JVBseaPLUhAFIvHXFMcbd0wsE8nyZ+DQOIaymMTyMOz8j/8tOMCDkW6UDu0eX+vqKLhK9sGsH mathieur@mathieu-vo-debia"
}


resource "tls_private_key" "provisionkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "digitalocean_ssh_key" "provisionkey" {
  name       = "provisionkey"
  public_key = "${tls_private_key.provisionkey.public_key_openssh}"
}

resource "digitalocean_droplet" "wireguard" {
  image  = var.droplet_image
  name   = "wireguard"
  region = var.droplet_region
  size   = var.droplet_size
  ssh_keys = [
    digitalocean_ssh_key.t460ksshey.id, 
    digitalocean_ssh_key.biniousshkey.id, 
    digitalocean_ssh_key.myscriptsshkey.id,
    digitalocean_ssh_key.provisionkey.id
  ]
  user_data = data.template_cloudinit_config.userdata.rendered
}
