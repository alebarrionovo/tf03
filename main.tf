terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.32.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

variable "do_token" {

}

resource "digitalocean_droplet" "web" {
  image    = "ubuntu-22-04-x64"
  name     = "wevm-labs"
  region   = "nyc1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [digitalocean_ssh_key.ssh.fingerprint]
}

resource "digitalocean_ssh_key" "ssh" {
  name       = "Terraform"
  public_key = file("~/Documents/digitalocean/terraform.pub")
}

output "ip" {
  value = digitalocean_droplet.web.ipv4_address
}