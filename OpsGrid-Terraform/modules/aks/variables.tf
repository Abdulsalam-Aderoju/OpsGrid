variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "environment" {
  type        = string
  description = "Environment name (dev or production)"
}

variable "aks_subnet_id" {
  type        = string
  description = "Subnet ID for AKS nodes"
}

variable "node_count" {
  type        = number
  description = "Number of nodes in the cluster"
}

variable "node_vm_size" {
  type        = string
  description = "VM size for the nodes"
}

variable "acr_id" {
  type        = string
  description = "ACR ID to grant AKS pull access"
}