resource "digitalocean_droplet" "www-1" {
  image = "ubuntu-18-04-x64"
  name = "www-1"
  region = "nyc1"
  # The size should be decided based on what the user is looking for here I'm using compute optimized
  size = "c-32"
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
      # install docker
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common",

      # add Docker GPG key
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - ",
      
      # add apt-repository 
      "sudo add-apt-repository 'deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable'",
                     
      # Update the list of packages available to download... then install docker
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",

      # Download docker image into VPS and Run the simulation
      "sudo docker run -dti --name=dt1 ck2136/pmmsknn-test",

      # Copy simulation results from container to VPS (do droplet)
      "sudo docker cp dt1:/usr/local/src/myscripts/data/sim1_NO_1000.RDS . "

      # Copy simulation results from VPS to original remote host
      #"sudo scp sim1_NO_1000.RDS ck1@ipaddress:/home/ck/Downloads/"
    ]
  }
}

