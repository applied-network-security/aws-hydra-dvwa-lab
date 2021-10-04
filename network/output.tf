# -- network/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.myinfra_vpc.id
}
output "public_sg" {
  value = aws_security_group.myinfra_sg["public"].id
}
output "public_subnets" {
  value = aws_subnet.myinfra_public_subnet.*.id
}
output "private_subnets" {
  value = aws_subnet.myinfra_private_subnet.*.id
}
output "dvwa_sg" {
  value = aws_security_group.myinfra_sg["dvwa"].id
}
output "bastion_sg" {
  value = aws_security_group.myinfra_sg["bastion"].id
}
