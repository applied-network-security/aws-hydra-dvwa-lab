output "dvwa_ip" {
  value = aws_instance.myinfra_node[0].public_dns
}
