module "rg"{
source = "./modules/rg"
resource_group_name = var.resource_group_name
location = var.location
}

module "networking" {
  source = "./modules/networking"
  vnet_name = "${var.aks_name}-vnet"
  subnet_name = "${var.aks_name}-subnet"
  nsg_name = "${var.aks_name}-nsg"
  location = module.rg.location
  resource_group_name = module.rg.resource_group_name
  environment = var.environment
  security_rules = var.security_rules
  depends_on = [module.rg]
}

module "aks" {
source = "./modules/aks"
    name = var.aks_name
    location = module.rg.location
    resource_group_name = module.rg.resource_group_name
    dns_prefix = var.dns_prefix
    node_name       = var.node_name
    min_count = var.min_count
    max_count = var.max_count
    vm_size    = var.vm_size
    environment = var.environment
    subnet_id = module.networking.subnet_id
    depends_on = [module.rg, module.networking]
}
