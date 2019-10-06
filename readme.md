# Terraform Configuration for Digital Ocean Droplet Orchestration

This repository contains terraform code to:

   1. Instantiate a digital ocean droplet
   2. Install and run rocker/r-devel instance
   3. Run PMMSKNN simulation script that utilizes the maximum allowabout CPU on a single droplet (32vCPU) for parallel processing

The user still needs to input the commands

```terraform
terraform plan -out=terraform.tfplan\
   -var "do_token= ${DO_PAT}" \
   -var "pub_key=$HOME/.ssh/id_rsa.pub" \
   -var "pvt_key=$HOME/.ssh/id_rsa" \
   -var "ssh_fingerprint=$SSH_FINGERPRINT" \


terraform apply terraform.tfplan
```

Where the `DO_PAT` and `SSH_FINGERPRINT` information can be generated through this [tutorial](https://www.digitalocean.com/community/tutorials/how-to-use-terraform-with-digitalocean)

For destroying the instance, add a `-destroy` tag:

```terraform
terraform plan -destroy -out=terraform.tfplan \
   -var "do_token= ${DO_PAT}" \
   -var "pub_key=$HOME/.ssh/id_rsa.pub" \
   -var "pvt_key=$HOME/.ssh/id_rsa" \
   -var "ssh_fingerprint=$SSH_FINGERPRINT" \

terraform apply terraform.tfplan
```

# Downloading the result of the simulation from the droplet

After instantiating the droplet, the results of the simulation script will not be passed through STDOUT (for linux). Therefore One should set a script that would transfer the file from the droplet to your computer and then one could set a script to notify the user that the file has been produced so that the instance may be destroyed (to save cost).

Below is the code to specify in the `www-1.tf` file:
```bash
"sudo scp sim1_BCCG_1000.RDS ck@ipaddress:/home/ck/Downloads/"
```

Currently there is no automatic procedure to destroy the instance. One could set up a hook/trigger to do so. If you hav eany ideas please let me know: [Email](mailto:chong.kim@ucdenver.edu)
