output "registry_elastic_ip" {
  value = "${aws_eip.default.public_ip}"
}

output "registry_public_ip" {
  value = "${aws_instance.docker_registry.public_ip}"
}
