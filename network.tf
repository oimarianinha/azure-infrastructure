# Criar Rede Virtual
resource "azurerm_virtual_network" "myvnet" {
  name                = "myVNet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Criar SubNet para Servidores Backend
resource "azurerm_subnet" "my_backend_subnet" {
  name                 = "myBackendSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes     = ["10.1.0.0/24"]
}

# Criar grupo de seguranca de rede e regra
resource "azurerm_network_security_group" "my_nsg" {
  name                = "myNSG"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {
    name                       = "myNSGRuleHTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "my_vm_nic" {
  count               = var.qtdade_resources
  name                = "myNicVM${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_configuration {
    name                          = "nicVM${count.index}Configuration"
    subnet_id                     = azurerm_subnet.my_backend_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Conecta NSG com as VMs
resource "azurerm_network_interface_security_group_association" "net_nsg_vm" {
  count                     = var.qtdade_resources
  network_interface_id      = azurerm_network_interface.my_vm_nic[count.index].id
  network_security_group_id = azurerm_network_security_group.my_nsg.id
}

# Criar IP publico para o Gateway
resource "azurerm_public_ip" "my_nat_gw_public_ip" {
  name                = "myNATGatewayIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  zones               = var.zones
}

# Cria um recurso NAT para gateway
resource "azurerm_nat_gateway" "my_nat_gw" {
  name                    = "myNatGateway"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  sku_name                = var.sku
  idle_timeout_in_minutes = 10
}

# Associa gateway com o IP publico
resource "azurerm_nat_gateway_public_ip_association" "my_gw_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.my_nat_gw.id
  public_ip_address_id = azurerm_public_ip.my_nat_gw_public_ip.id
}

# Associa gateway com a subnet
resource "azurerm_subnet_nat_gateway_association" "my_nat_gw_association" {
  subnet_id      = azurerm_subnet.my_backend_subnet.id
  nat_gateway_id = azurerm_nat_gateway.my_nat_gw.id
}