terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "1.22.2"
    }
    gandi = {
      version = "2.0.0-rc3"
      source   = "github/go-gandi/gandi"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "template" {
}
