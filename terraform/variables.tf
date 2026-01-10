# Region where resources will be created
variable "location" {
  type        = string
  description = "Azure region"
  default     = "westeurope"
}

# Resource Group name (container for all resources)
variable "rg_name" {
  type        = string
  description = "Resource Group name"
  default     = "rg-ace-minilab"
}

# Networking
variable "vnet_name" {
  type        = string
  description = "Virtual Network name"
  default     = "vnet-ace-minilab"
}

variable "vnet_cidr" {
  type        = string
  description = "VNet address space"
  default     = "10.10.0.0/16"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
  default     = "app-subnet"
}

variable "subnet_cidr" {
  type        = string
  description = "Subnet address space"
  default     = "10.10.1.0/24"
}

# VM identity
variable "vm_name" {
  type        = string
  description = "VM name"
  default     = "vm-ace-minilab-01"
}

variable "admin_username" {
  type        = string
  description = "Linux admin username"
  default     = "azureuser"
}

# SSH key (public) for secure login (no password)
variable "ssh_public_key_path" {
  type        = string
  description = "Path to SSH public key"
  default     = "~/.ssh/id_rsa.pub"
}

# Your IP in CIDR (/32) to restrict SSH access to ONLY you
variable "my_ip_cidr" {
  type        = string
  description = "Your public IP in CIDR format, e.g., 41.x.x.x/32"
}

