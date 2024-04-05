#Criar maquina virtual Linux Ubuntu
resource "azurerm_linux_virtual_machine" "LinuxUbuntu" {
  name                = "VM-Linux-Ubuntu"
  resource_group_name = azurerm_resource_group.grupo.name
  location            = azurerm_resource_group.grupo.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Senai@134134" # Definir a senha do administrador
  network_interface_ids = [
    azurerm_network_interface.rede.id
  ]


  #Definir o disco
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  #Definir a imagem Ubuntu
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  #Ativar autenticação por senha
  disable_password_authentication = false
}

#Associar subnet
resource "azurerm_subnet_network_security_group_association" "public_nsg_association" {
  subnet_id                 = azurerm_subnet.SubPublica1.id
  network_security_group_id = azurerm_network_security_group.sglinux.id

}

#imprime o usuario
output "admin_username" {
  value = azurerm_linux_virtual_machine.LinuxUbuntu.admin_username
}

#imprime a senha
output "admin_password" {
  value     = azurerm_linux_virtual_machine.LinuxUbuntu.admin_password
  sensitive = true
}
