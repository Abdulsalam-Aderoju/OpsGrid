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

variable "vnet_address_space" {
  type        = string
  description = "Address space for the VNet"
}

variable "aks_subnet_prefix" {
  type        = string
  description = "Address prefix for AKS subnet"
}