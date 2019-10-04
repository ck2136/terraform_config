# Terraform Configuration for Digital Ocean Droplet Orchestration

This repository contains terraform code to:

   1. Instantiate a digital ocean droplet
   2. Install r-base in the apt repo

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
