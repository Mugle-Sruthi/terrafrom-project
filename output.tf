output "instance_ips" {
  value = [for instance in aws_instance.ubuntu_instance : instance.public_ip]
}
