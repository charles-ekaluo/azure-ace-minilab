############################
# 1) Resource Group + Tags
############################
# Resource Group = a container that makes cleanup and governance easier.
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location

  # Tags help governance and cost tracking (basic enterprise hygiene)
  tags = {
    owner      = "charles-ekaluo"
    env        = "lab"
    service    = "cloud-ops"
    costCenter = "internalIT"
  }
}

############################
# 2) VNet + Subnet
############################
# VNet = private network in Azure
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = [var.vnet_cidr]
}

# Subnet = smaller network where the VM will live
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_cidr]
}

############################
# 3) NSG + SSH rule
############################
# NSG = firewall rules. We'll attach it to the subnet.
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.subnet_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Allow SSH ONLY from your public IP (security best practice)
resource "azurerm_network_security_rule" "allow_ssh_from_me" {
  name                        = "allow-ssh-from-my-ip"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.my_ip_cidr
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Apply NSG to the subnet so the VM inherits these rules
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

############################
# 4) Public IP + NIC
############################
# Public IP lets you SSH from your laptop (lab convenience).
resource "azurerm_public_ip" "pip" {
  name                = "pip-${var.vm_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# NIC connects the VM to the subnet (and the public IP)
resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.vm_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

############################
# 5) Ubuntu VM
############################
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_E2s_v3"
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  # SSH key login (safer than passwords)
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key_path)
  }

  # VM disk settings
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  # Ubuntu 22.04 LTS image
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

