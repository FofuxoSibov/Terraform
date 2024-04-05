provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "grupo" {
  name     = "AzureRT"
  location = "East US"
}
