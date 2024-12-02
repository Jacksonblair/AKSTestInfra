
variable "resource_group_name" {
  type        = string
  default     = "example-resource-group"
  description = "The name of the resource group to create."
}

variable "resource_group_location" {
  type        = string
  default     = "AustraliaEast"
  description = "The location where the resource group will be created."
}

provider "azurerm" { 
  features {}
}

# Create the resource group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# Create the container registry
resource "azurerm_container_registry" "example" {
  name                     = "testacr"
  location                 = azurerm_resource_group.example.location
  resource_group_name      = azurerm_resource_group.example.name
  sku                      = "Basic"
  admin_enabled            = true
}

# Create the AKS cluster
resource "azurerm_kubernetes_cluster" "example" {
  name                = "test-aks-cluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
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

# Output the kube_config for the AKS cluster
output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config
}