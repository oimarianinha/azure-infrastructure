variable "subscription_id" {
  type        = string
  description = "Azure subscription_id"
  default = ""
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant id"
  default = ""
}
variable "client_id" {
  type        = string
  description = "Azure client id"
  default = ""
}
variable "client_secret" {
  type        = string
  description = "Azure clinet secret"
  default = ""
}

variable "username" {
  type        = string
  description = "O usuario que vai ser usado pra acessar a VM."
  default     = "ubuntu"
}

variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Local do grupo de recursos"
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefixo para o grupo de recursos que vai ser combinado com um nome randomico."
}

variable  "qtdade_resources" {
  type = number
  default = 2
  description = "Quantidade de VMs que deseja subir" 
}

variable "zones" {
  type = list(any)
  default = ["1", "2", "3"]
  description = "Lista de zonas de disponibilidade"
  
}

variable "sku" {
  type = string
  default = "Standard"
  description = "Tipo de armazenamento SKU"
  
}

variable "allocation_method" {
  type = string
  default = "Static"
  description = "Método de alocacao"
  
}