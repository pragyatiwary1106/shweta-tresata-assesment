module "rg"{
source = "./modules/rg"
resource_group_name = var.resource_group_name
location = var.location
}

module "aks" {
source = "./modules/aks"
    name = var.aks_name
    location = module.rg.location
    resource_group_name = module.rg.resource_group_name
    dns_prefix = var.dns_prefix
    node_name       = var.node_name
    node_count = var.node_count
    vm_size    = var.vm_size
    environment = var.environment
    depends_on = [module.rg]


}
