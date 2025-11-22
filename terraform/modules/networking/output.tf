output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.aks_vnet.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.aks_subnet.id
}

output "nsg_id" {
  description = "ID of the network security group"
  value       = azurerm_network_security_group.aks_nsg.id
}