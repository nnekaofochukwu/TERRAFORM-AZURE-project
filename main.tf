resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = "nneka-vnet"
  address_space       = var.virtual_network_address_space
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "nneka-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_public_ip" "vm_nneka_pip" {
  name                = "pip-nneka"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Define network interfaces for backend servers
resource "azurerm_network_interface" "backend" {
  count               = 4
  name                = "nic-backend-${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Define network interfaces for frontend servers
resource "azurerm_network_interface" "frontend" {
  count               = 2
  name                = "nic-frontend-${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "backend" {
  name                  = "tfbackend"
  count                 = 4
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  vm_size               = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.backend[count.index].id]
  zones                 = [abs(2)]

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  storage_os_disk {
    name              = "mybackendosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "tfbackend"
    admin_username = "nnekaTF"
    admin_password = "xxxxxx"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

resource "azurerm_virtual_machine" "frontend" {
  name                  = "tffrontend"
  count                 = 2
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  vm_size               = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.frontend[count.index].id]
  zones                 = [abs(2)]


  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myfrontendosdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "tffrontend"
    admin_username = "nnekaTF"
    admin_password = "xxxxxxx"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    Name = "HelloWorld-${count.index}"
  }
}
resource "azurerm_storage_account" "example" {
  name                     = "nnekastoraccount"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#  tags = {
#    environment = "staging"
#  }
#}

resource "azurerm_storage_container" "example" {
  name                 = "vhds"
  storage_account_name = azurerm_storage_account.example.name
  # container_access_type = "private"
}

#resource "azurerm_storage_blob" "example" {
# name                   = "my-awesome-content.zip"
#storage_account_name   = azurerm_storage_account.example.name
#storage_container_name = azurerm_storage_container.example.name
#type                   = "Block"
#source                 = "some-local-file.zip"
#}

resource "azurerm_network_security_group" "example" {
  name                = "nneka-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "allow-ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-http"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-https"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
#tags = {
#environment = "Production"
#}
#}

#resource "azurerm_subnet_network_security_group_association" "main" {
#  subnet_id                 = azurerm_subnet.main.id
#  network_security_group_id = azurerm_network_security_group.main.id
#}

# Create an Azure AD user
resource "azuread_user" "example_user" {
  display_name        = var.user_display_name
  user_principal_name = var.user_principal_name
  mail_nickname       = var.user_mail_nickname
  password            = var.user_password
}
