## terraformy

### References

https://github.com/Praqma/terraform-aws-docker

https://serverfault.com/questions/706336/how-to-get-a-pem-file-from-ssh-key-pair

### Keys

Not sure how this is going to work, here's the current steps:

1. `ssh -t rsa -C "$email"`
  * I write the file to `aws_rsa`, not sure if there's a good convention
  * Note that the private key should be in `PEM` format already
2. `ssh-keygen -f aws_rsa.pub -m 'PEM' -e > aws_rsa_pub.pem`
  * This converts the public key to `PEM`
