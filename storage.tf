# Gera texto randomico para storage
resource "random_id" "random_vm_id" {
  count   = 2
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg.name
  }
  byte_length = 8
}

# Cria conta storage VMs pra diagnosticar boot
resource "azurerm_storage_account" "my_vm_storage_account" {
  count                    = 2
  name                     = "diag${random_id.random_vm_id[count.index].hex}"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}