resource "azurerm_network_interface" "test" {
  name                = "NIC-${var.resource_type}-${var.application_type}"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.public_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                  = "${var.resource_type}-${var.application_type}"
  location              = var.location
  resource_group_name   = var.resource_group
  size                  = "Basic_A1"
  admin_username        = "stephenmooney"

  network_interface_ids = [
    azurerm_network_interface.test.id
  ]
  
  admin_ssh_key {
    username   = "stephenmooney"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC04xeHCvsn11BrQ0EU7PZ2DzGzrlycvkgb0w6FXUtcu8gN9i1qdUu+QSZcHyWixTcVAMCQwrmZm8OQm+1cJT6N2OY30uhDBX7rf4DNY6jDSVRbszgceujbYzwdmC9FX0moY9k9FcZhl7Farl66Yn+QxugqNpLAjSpqpe39qgDRqeIklIK2FtSnCnDThZPFpxObQ10xXMW6oFeIh8mijPyz5+Ot/xa5gg32eVizkA08vaKVkRh3gkyr6hMM853ZbPvfxEOZeLPeMWsUvDSruLrfroe9SCe9qJqgH9OHzJwxDNsKZEDNmPoOxOUVfQiuwjRUr6J4FJq/4j4NNbkhJMG06C9VDR7mxPJ75sBemE9A2h6YvsdR+s48mLuyTwRyuXJTvajFQHXkXXEFY2kADbAB+ZKsAeh9CTf2iTp/4jF8buiaABfnea3X+CoiqxS6I6UABVevrIKJQqJtvXrXpsyMq59xNd77VdtbZAj5/yNOf9+qEQlRhu38IptaytUV/OM="
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}