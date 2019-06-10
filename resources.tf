provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_eip" "default" {
  instance = "${aws_instance.docker_registry.id}"
  vpc      = true
}

resource "aws_instance" "docker_registry" {
  ami           = "ami-024a64a6685d05041"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.deployer.key_name}"

  security_groups = ["${aws_security_group.docker_registry.name}"]

  connection {
    user     = "ubuntu"
    key_file = "ssh/key"
  }

  # provisioner "file"
  # {
  #   source      = "key.pem"
  #   destination = "/home/ubuntu/key.pem"
  # }

  # Install Docker on the registry
  user_data = "${file("userdata.sh")}"

  tags = {
    Name = "Docker_Registry"
  }
}

resource "aws_instance" "windows_docker_host" {
  ami           = "ami-0905611575f2f7ae0"
  instance_type = "t2.micro"

  # TODO: install docker, if it isn't already

  tags = {
    Name = "Windows_Docker_Host"
  }
}
