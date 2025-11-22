resource "azurerm_kubernetes_cluster" "aks" {

    name = var.name
    location = var.location
    resource_group_name = var.resource_group_name
    dns_prefix = var.dns_prefix

    default_node_pool {
    name                = var.node_name
    vm_size             = var.vm_size
    auto_scaling_enabled  = true 
    min_count          = var.min_count
    max_count          = var.max_count
    node_count         = var.min_count
    vnet_subnet_id     = var.subnet_id
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr   = "172.16.0.0/16"
    dns_service_ip = "172.16.0.10"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = var.environment
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }
}
