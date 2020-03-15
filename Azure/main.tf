# Deploy a Ubuntu Linux on GFT Azure

provider "azurerm" {
  version = ">2.0.0"
  features {}
}

# Create a resource group

resource "azurerm_resource_group" "gft-pip-rg" {
  name     = var.resource_group
  location = var.location
}

# Create a Virtual Network

resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.gft-pip-rg.location
  address_space       = ["${var.address_space}"]
  resource_group_name = azurerm_resource_group.gft-pip-rg.name
}

# Create a subnet for VMs to run in

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.gft-pip-rg.name
  address_prefix       = var.subnet_prefix
}

# Build an Ubuntu linux VM

# SG to allow inbound on port 80 and 22 

resource "azurerm_network_security_group" "gft-pip-sg" {
  name                = "${var.prefix}-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.gft-pip-rg.name

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = var.source_network
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.source_network
    destination_address_prefix = "*"
  }
}

# Build a network interface

resource "azurerm_network_interface" "gft-pip-nic" {
  count                     = var.inst_count
  name                      = "${var.prefix}-gft-pip-nic${format("%02d", count.index + 1)}"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.gft-pip-rg.name

  ip_configuration {
    name                          = "${var.prefix}ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.gft-pip-pip.*.id, count.index +1)
  }
}

# Create a public IP address 

resource "azurerm_public_ip" "gft-pip-pip" {
  count                        = var.inst_count
  name                         = "${var.prefix}-ip${format("pubip%02d", count.index + 1)}"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.gft-pip-rg.name
  allocation_method            = "Static"
  domain_name_label            = "${var.hostname}${format("%02d", count.index + 1)}"
}

# Build the VM

resource "azurerm_virtual_machine" "vm" {
  count                     = var.inst_count
  name                = "${var.hostname}${format("%02d", count.index + 1)}"
  location            = var.location
  resource_group_name = azurerm_resource_group.gft-pip-rg.name
  vm_size             = var.vm_size

  network_interface_ids         = [element(azurerm_network_interface.gft-pip-nic.*.id, count.index)]

  delete_os_disk_on_termination = "true"
  

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name              = "${var.hostname}-osdisk${format("%02d", count.index +1)}"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = var.hostname
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}