# Cria as VMs
resource "azurerm_linux_virtual_machine" "my_vm" {
  count                 = var.qtdade_resources
  name                  = "myVM${count.index}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.my_vm_nic[count.index].id]
  size                  = "Standard_DS1_v2"
  os_disk {
    name                 = "myVM${count.index}OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  computer_name  = "vm${count.index}"
  admin_username = var.username
  admin_ssh_key {
    username   = var.username
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_vm_storage_account[count.index].primary_blob_endpoint
  }
  depends_on = [ 
    azurerm_network_interface_security_group_association.net_nsg_vm
  ]
}

# Adiciona VMs no Address pool
resource "azurerm_network_interface_backend_address_pool_association" "my_nic_vm_addresspool" {
  count                   = var.qtdade_resources
  network_interface_id    = azurerm_network_interface.my_vm_nic[count.index].id
  ip_configuration_name   = "nicVM${count.index}Configuration"
  backend_address_pool_id = azurerm_lb_backend_address_pool.my_backend_pool.id
  depends_on = [ 
    azurerm_subnet.my_backend_subnet 
  ]
}