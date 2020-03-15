output "PublicIPs" {
  value = [aws_instance.gft.*.public_ip]
}

output "dns_name" {
  value = [aws_instance.gft.*.public_dns]
}

output "dns_name_with_vol" {
  value = [aws_instance.gft.*.public_dns,aws_volume_attachment.ebs_attach.*.volume_id]
}
