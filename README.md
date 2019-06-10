# terraformy

## References

https://github.com/Praqma/terraform-aws-docker

https://serverfault.com/questions/706336/how-to-get-a-pem-file-from-ssh-key-pair

https://ifritltd.com/2017/12/06/provisioning-ec2-key-pairs-with-terraform/

https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/eip

## Instructions

### Installation

Install `terraform` for your platform: https://www.terraform.io/

Might also be nice to get the `aws-cli` if you want to look into having that manage your credentials.

### Keys

Not sure how this is going to work, here's the current steps:

1. `mkdir keys` and `cd keys`
2. `ssh -t rsa -C "$email"`
  * I write the file to `aws_rsa`, not sure if there's a good convention
  * Note that the private key should be in `PEM` format already
3. `ssh-keygen -f aws_rsa.pub -m 'PEM' -e > aws_rsa_pub.pem`
  * This converts the public key to `PEM`
  
Turns out we don't need to do step 2! Leaving it here anyway.

### Credentials

1. Create an `AWS`` account if you don't have one
2. Create an `IAM` role for `terraform` to use. I created one called `terraform` and gave it `programmatic access` and basically full `admin` privileges`. That's bad though.
3. Get the `access key` and `secret key` and create a file called `terraform.tfvars` that looks like this, but with your keys filled in:

```
access_key = "access key"
secret_key = "secret key"
```

  * Or you could use the `aws-cli` to manage this, `terraform` will check in `~/.aws/credentials`

### terraform

1. `terraform plan`

If all is setup correctly `terraform` will write a fair bit to the screen
describing what it's going to do.

2. `terraform apply` and say 'yes'

`terraform` will now create the various `AWS` bits. At the end note the elastic
IP.

You can then `ssh` into the Linux instance with

```
ssh -i keys/the_private_key ubuntu@the_elastic_ip
```

That is assuming all the security settings are good on your instance (see
`security_group.tf`) and your VPC.

