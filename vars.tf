variable "sshpublickeys" {
  type = list(string)
  default = []
}


# Populate token from value provided in previous step
variable "do_token" {
  type      = string
  sensitive = true
  default   = ""
}


## optional variables (do not require edit before launch)

variable "droplet_image" {
  type        = string
  description = "Image to launch"
  default     = "ubuntu-22-04-x64"
}

variable "droplet_region" {
  type    = string
  default = "sgp1"
}

variable "droplet_size" {
  type        = string
  description = "Size of droplet"
  default     = "s-1vcpu-512mb-10gb"
}


variable "wg_privatekey" {
  type        = string
  description = "wireguard private key"
}

variable "wg_publickey" {
  type        = string
  description = "wireguard public key"
}