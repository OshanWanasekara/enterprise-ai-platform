
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "1f68e002-4843-45a3-904f-5dc22c2ab0af"
  resource_provider_registrations = "none"  
}

resource "local_file" "platform_config" {
  filename = "${path.module}/generated/platform-info.txt"

  content = <<-EOT
    Application: Enterprise AI Platform
    Environment: Development
    Platform: Docker and Kubernetes
    Application Port: 8000
  EOT
}

resource "azurerm_resource_group" "ai_platform" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "development"
    project     = "enterprise-ai-platform"
    managed_by  = "terraform"
  }
}

