resource "digitalocean_droplet" "www-1" {
  image = "ubuntu-18-04-x64"
  name = "www-1"
  region = "nyc1"
  size = "1gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]

  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
    host = "${self.ipv4_address}"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install R

      ## Adds the CRAN GPG key, which is used to sign the R packages for security.
      "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9",

      ## Add apt repo for R
      "sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'",

      "sudo apt-get update",
      "sudo apt-get install -y r-base"
    ]
  }
}

