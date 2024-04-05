resource "azurerm_storage_account" "fofuxoarmazenamento" {
  name                     = "fofuxoarmazenamento"
  resource_group_name      = "AzureRT"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "TerraformRT"
  }
}

resource "azurerm_storage_container" "website" {
  name                  = "website"
  storage_account_name  = azurerm_storage_account.fofuxoarmazenamento.name
  container_access_type = "blob"
}

resource "null_resource" "upload_files_to_blob" {
  depends_on = [azurerm_storage_container.website]

  provisioner "local-exec" {
    command = "az storage blob upload-batch --destination ${azurerm_storage_container.website.name} --account-name ${azurerm_storage_account.fofuxoarmazenamento.name} --source ./sitebike"
  }
}

output "index_html_url" {
  value = "https://${azurerm_storage_account.fofuxoarmazenamento.name}.blob.core.windows.net/${azurerm_storage_container.website.name}/index.html"
}