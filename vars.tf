## variables that require editing before launch

variable "pvt_key" {
  type      = string
  sensitive = true
  default   = ""
}
# Populate token from value provided in previous step
variable "do_token" {
  type      = string
  sensitive = true
  default   = ""
}


variable "ssh_key_fingerprint" {
  type        = string
  sensitive   = true
  description = "fingerprint of SSH key that you uploaded to digitalocean"
  default     = ""
}


variable "dynu_credentials" {
  type        = string
  sensitive   = true
  description = "Credentials in the form 'username:password' (password can also be an API key)"
  default     = ""
}

variable "dynu_domain" {
  type        = string
  description = "Full URL of your domain like thisfunkyhostname.loseyourip.com"
  default     = ""
}

variable "dynu_api_key" {
  type        = string
  sensitive   = true
  description = "The secret API key that you create within the Dynu admin interface"
  default     = ""
}

variable "le_email_addr" {
  type        = string
  sensitive   = true
  description = "The email address linked with your let's encrypt certificate registration"
  default     = ""
}

variable "wgui_username" {
  type        = string
  description = "The username that you will use to login to the wireguard UI portal"
  default     = ""
}

variable "wgui_password" {
  type        = string
  sensitive   = true
  description = "The password that you will use to login to the wireguard UI portal"
  default     = ""
}

## optional variables (do not require edit before launch)

variable "droplet_image" {
  type        = string
  description = "Image to launch"
  default     = "ubuntu-20-04-x64"
}

variable "droplet_region" {
  type    = string
  default = "sfo3"
}

variable "droplet_size" {
  type        = string
  description = "Size of droplet"
  default     = "s-1vcpu-1gb"
}