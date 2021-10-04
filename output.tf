output "dvwa_ip" {
  value = "ssh ec2-user@${module.dvwa.dvwa_ip}"
}

output "bastion_ip" {
  value = "ssh ec2-user@${module.bastion.bastion_ip}"
}

