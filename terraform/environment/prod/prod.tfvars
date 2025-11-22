subscription_id = "3ceca0c5-c2dd-4175-aa75-80d12e1b88cb"
resource_group_name = "prod-rg"
location    = "West Europe"
aks_name    = "Akscluster-prod-pragya"
dns_prefix  = "kubepragya-prod"
node_name   = "kube-worker-prod1"
min_count   = 2
max_count   = 10
vm_size = "Standard_D2_v2"
environment     = "prod"

security_rules = [
  {
    name                       = "AllowHTTPS"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "AllowHTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "DenyAll"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]