#Definir o provedor Azure
provider "azurerm" {
  features {}
}

#Criar grupo de recursos e definir região
resource "azurerm_resource_group" "grupo" {
  name     = "AzureRM"
  location = "East US"
}

#Definição da conta de armazenamento e alterações
resource "azurerm_storage_account" "fofuxoarmazem" { #Trocar conta de Armazenamento
  name                     = "fofuxoarmazem" #Deixa igual
  resource_group_name      = "AzureRM"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS" #Definimos um unico local de redundancia

  tags = {
    environment = "TerraformAzure"
  }
}