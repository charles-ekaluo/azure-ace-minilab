# Prints the VM public IP after deployment (so you can SSH easily)
output "vm_public_ip" {
  value       = azurerm_public_ip.pip.ip_address
  description = "Public IP of the VM"
}

