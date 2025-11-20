variable "subscription_id" {
    description = "subscription id"
type = string
}
# variable "key"{
# description = "key of storage account"
# type = string
# }
variable "resource_group_name"{
description = "resource group name"
type = string
}
variable "location" {
description = "location of rg"
type = string
}
variable "aks_name"{
description = "aks cluster name"
type = string
}
variable "dns_prefix"{
description = "prefix for dns"
type = string
}
variable "node_name"{
description = "node name"
type = string
}
variable "node_count"{
description = "node count"
type = number
}
variable "vm_size"{
description = "size of vm"
type = string
}
variable "environment"{
description = "prod/dev/staging"
type = string
}


