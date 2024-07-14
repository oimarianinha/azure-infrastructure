output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
output "public_ip_address" {
  value = azurerm_public_ip.my_public_ip.*.ip_address
}
output "vm_private_ip_address" {
  value = azurerm_linux_virtual_machine.my_vm.*.private_ip_address
}
output "bastion_public_ip_address" {
  value = azurerm_public_ip.my_bastion_ip.*.ip_address
}
