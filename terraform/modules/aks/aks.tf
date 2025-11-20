resource "azurerm_kubernetes_cluster" "aks" {

    name = var.name
    location = var.location
    resource_group_name = var.resource_group_name
    dns_prefix = var.dns_prefix

    default_node_pool {
    name                = var.node_name
    vm_size             = var.vm_size
    auto_scaling_enabled = true 
    min_count          = var.min_count
    max_count          = var.max_count

  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment
  }
}
