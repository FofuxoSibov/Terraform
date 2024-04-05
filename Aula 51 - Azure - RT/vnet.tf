resource "azurerm_virtual_network" "CloudPlayNet" {
  name                = "CloudPlayNET"
  address_space       = ["172.16.0.0/16"]
  location            = "East US"
  resource_group_name = "AzureRT"
}

resource "azurerm_subnet" "public" {
  name                 = "Subredepub"
  resource_group_name  = "AzureRT"
  virtual_network_name = azurerm_virtual_network.CloudPlayNet.name
  address_prefixes     = ["172.16.1.0/24"]

}

resource "azurerm_subnet" "private" {
  name                 = "Subredepri"
  resource_group_name  = "AzureRT"
  virtual_network_name = azurerm_virtual_network.CloudPlayNet.name
  address_prefixes     = ["172.16.2.0/24"]
}

resource "azurerm_network_security_group" "sg" {
  name                = "GrupoLinux"
  location            = azurerm_resource_group.grupo.location
  resource_group_name = azurerm_resource_group.grupo.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "public_nsg_association" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.sg.id

}

resource "azurerm_network_interface" "rede" {
  name                = "RedeLinux"
  location            = azurerm_resource_group.grupo.location
  resource_group_name = azurerm_resource_group.grupo.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id # Associar IP público à interface de rede
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip"
  location            = azurerm_resource_group.grupo.location
  resource_group_name = azurerm_resource_group.grupo.name
  allocation_method   = "Dynamic"
}

output "public_ip_address" {
  value = azurerm_public_ip.public_ip.ip_address
}

output "admin_username" {
  value = azurerm_linux_virtual_machine.linux_vm.admin_username
}

output "admin_password" {
  value     = azurerm_linux_virtual_machine.linux_vm.admin_password
  sensitive = true
}