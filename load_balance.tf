# Gerar um probe de saude do load balancer
resource "azurerm_lb_probe" "my_load_balancer_probe" {
  loadbalancer_id = azurerm_lb.my_load_balancer.id
  name            = "myHealthProbe"
  port            = 80
  protocol        = "Tcp"
}

# Criar regra de Load Balancer
resource "azurerm_lb_rule" "my_load_balancer_rule" {
  probe_id                       = azurerm_lb_probe.my_load_balancer_probe.id
  loadbalancer_id                = azurerm_lb.my_load_balancer.id
  name                           = "myHTTPRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "myFrontEnd"
  disable_outbound_snat          = "true"
  idle_timeout_in_minutes        = 15
  enable_tcp_reset               = "true"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.my_backend_pool.id]
}

# Criar um load balancer (LB)
resource "azurerm_lb" "my_load_balancer" {
  name                = "myLoadBalancer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.sku
  frontend_ip_configuration {
    name                 = "myFrontEnd"
    public_ip_address_id = azurerm_public_ip.my_public_ip.id
  }
}

# Gerar um backend pool
resource "azurerm_lb_backend_address_pool" "my_backend_pool" {
  loadbalancer_id = azurerm_lb.my_load_balancer.id
  name            = "myBackEndPool"
}

# Criar IP publico para o LB
resource "azurerm_public_ip" "my_public_ip" {
  name                = "myPublicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  zones               = var.zones
}
