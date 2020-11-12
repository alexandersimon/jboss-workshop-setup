output "ssh-public-key" {
  value     = tls_private_key.key.public_key_pem
  sensitive = true
}

output "ssh-private-key" {
  value     = tls_private_key.key.private_key_pem
  sensitive = true
}

output "ssh-public-key-openssh" {
  value     = tls_private_key.key.public_key_openssh
  sensitive = true
}

output "private-ips" {
  value = { for inst in aws_instance.server : inst.tags["Name"] => inst.private_ip }
}

output "public-dns" {
  value = { for inst in aws_instance.server : inst.tags["Name"] => inst.public_dns }
}
