output "ssh-key-pem-public" {
  value     = tls_private_key.key.public_key_pem
  sensitive = true
}

output "ssh-key-pem" {
  value     = tls_private_key.key.private_key_pem
  sensitive = true
}

output "ssh-key-public-openssh" {
  value     = tls_private_key.key.public_key_openssh
  sensitive = true
}

output "dns-cicd" {
  value = aws_instance.cicd.public_dns
}

output "dns-lb" {
  value = aws_instance.lb.public_dns
}

output "dns-jboss-0" {
  value = aws_instance.jboss.0.public_dns
}

output "dns-jboss-1" {
  value = aws_instance.jboss.1.public_dns
}

output "dns-mon" {
  value = aws_instance.mon.public_dns
}