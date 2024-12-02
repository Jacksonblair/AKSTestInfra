provider "azurerm" {
  features {}
}

variable "resource_group" {
  type = string
}

resource "azurerm_container_registry" "example" {
  name                     = "testacr"
  location                 = "AustraliaEast"
  resource_group_name      = var.resource_group
  sku                      = "Basic"
  admin_enabled            = true
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "test-aks-cluster"
  location            = "AustraliaEast"
  resource_group_name = var.resource_group
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config
}
