#output "gft_dns" {
#  value = "${azurerm_public_ip.gft-pip-pip.*.fqdn}"
#}

output "gft-demo-srvr-public-ip" {
  value = [azurerm_public_ip.gft-pip-pip.*.ip_address, azurerm_public_ip.gft-pip-pip.*.fqdn]
}