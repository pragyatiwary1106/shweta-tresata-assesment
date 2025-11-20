variable "name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "Azure region where the AKS cluster will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "node_name" {
  description = "Name of the default node pool"
  type        = string
}

variable "min_count" {
  description = "Minimum number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Maximum number of nodes in the default node pool"
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "Size of the virtual machines in the node pool"
  type        = string
}

variable "environment" {
  description = "Environment tag"
  type        = string
}