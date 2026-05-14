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

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

variable "object_id" {
  type        = string
  description = "Object ID of the current user or service principal"
}

variable "aks_kubelet_object_id" {
  type        = string
  description = "Object ID of AKS kubelet identity for secret access"
}