#Criar rede virtual com nome CloudPlay - 172.16.0.0/16
resource "azurerm_virtual_network" "CloudPlay" {
  name                = "CloudPlay"
  address_space       = ["172.16.0.0/16"]
  location            = "East US"
  resource_group_name = "AzureRM"
}

#Criar SubRede Publica = SubPublica1 - 172.16.1.0/24
resource "azurerm_subnet" "SubPublica1" {
  name                 = "SubPublica1" #nome igual
  resource_group_name  = "AzureRM"
  virtual_network_name = azurerm_virtual_network.CloudPlay.name
  address_prefixes     = ["172.16.1.0/24"]
}

#Criar SubRede Privada = SubPrivada1 - 172.16.2.0/24
resource "azurerm_subnet" "SubPrivada1" {
  name                 = "SubPrivada1" #nome igual
  resource_group_name  = "AzureRM"
  virtual_network_name = azurerm_virtual_network.CloudPlay.name
  address_prefixes     = ["172.16.2.0/24"]
  #procurar o tic
}

#Criar grupo de segurança
resource "azurerm_network_security_group" "sglinux" {
  name                = "Grupo-Sec-Linux"
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

#Definição de qual grupo e subrede a instacia usara
resource "azurerm_network_interface" "rede" {
  name                = "RedeLinux"
  location            = azurerm_resource_group.grupo.location
  resource_group_name = azurerm_resource_group.grupo.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SubPublica1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id # Associar IP público à interface de rede
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