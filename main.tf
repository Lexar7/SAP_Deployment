# Configure the Microsoft Azure Provider.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "GrupoRamos_EU2_RG_EA"
  location = var.location
}

# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vNet_GrupoRamos_EA"
  address_space       = ["192.168.92.0/23"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "Subnet_Servidores"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.92.0/24"]
}

/////////////// GRUPO 1 NO PRODUCTIVOS ///////////////
# Create network interface
resource "azurerm_network_interface" "nics_grupo1" {
  count               = 9
  name                = element(var.vm_nics_grupo1,count.index)
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "NICConfg"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "static"
    private_ip_address = element(var.vm_private_ip_grupo1,count.index)
  }
}

# Create a virtual machines 
resource "azurerm_virtual_machine" "vm" {
  count                 = 9
  name                  = element(var.vm_names_grupo1,count.index)
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.nics_grupo1.*.id, count.index)]
  vm_size               = element(var.vm_size_grupo1,count.index)

  storage_os_disk {
    name              = element(var.vm_osdisk_name_grupo1,count.index)
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = element(var.vm_osdisk_size_grupo1,count.index)
  }

 # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = false

 # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = false

  storage_image_reference {
    publisher = element(var.image_reference_publisher,count.index)
    offer     = element(var.vm_image_offer,count.index)
    sku       = element(var.sku,count.index)
    version   = "latest"
  }

  os_profile {
    computer_name  = element(var.vm_names_grupo1,count.index)
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}

# Extra disks for vhgrrpoddb01
resource "azurerm_managed_disk" "managedisk_vhgrrpoddb01" {
  count                = length(var.extradisks_vhgrrpoddb01)  
  name                 = element(var.extradisks_vhgrrpoddb01,count.index)
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = element(var.extradisks_storage_account_type1,count.index)
  create_option        = element(var.extradisks_create_option1,count.index)
  disk_size_gb         = element(var.extradisks_disk_size1,count.index)
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattachment_vhgrrpoddb01" {
  count              = 4
  managed_disk_id    = element(azurerm_managed_disk.managedisk_vhgrrpoddb01.*.id, count.index)
  virtual_machine_id = element(azurerm_virtual_machine.vm.*.id, element(var.disk_vm_vhgrrpoddb01, count.index))
  lun                = element(var.disk_attachment_lun1,count.index)
  caching            = element(var.disk_attachment_caching1,count.index)
}

# Extra disks for vhgrrcaqdb01
resource "azurerm_managed_disk" "managedisk_vhgrrcaqdb01" {
  count                = length(var.extradisks_vhgrrcaqdb01)  
  name                 = element(var.extradisks_vhgrrcaqdb01,count.index)
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = element(var.extradisks_storage_account_type2,count.index)
  create_option        = element(var.extradisks_create_option2,count.index)
  disk_size_gb         = element(var.extradisks_disk_size2,count.index)
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattachment_vhgrrcaqdb01" {
  count              = 11  
  managed_disk_id    = element(azurerm_managed_disk.managedisk_vhgrrcaqdb01.*.id, count.index)
  virtual_machine_id = element(azurerm_virtual_machine.vm.*.id, element(var.disk_vm_vhgrrcaqdb01, count.index))
  lun                = element(var.disk_attachment_lun2,count.index)
  caching            = element(var.disk_attachment_caching2,count.index)
}

# Extra disks for vhgrrcaddb01
resource "azurerm_managed_disk" "managedisk_vhgrrcaddb01" {
  count                = length(var.extradisks_vhgrrcaddb01)  
  name                 = element(var.extradisks_vhgrrcaddb01,count.index)
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = element(var.extradisks_storage_account_type3,count.index)
  create_option        = element(var.extradisks_create_option3,count.index)
  disk_size_gb         = element(var.extradisks_disk_size3,count.index)
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattachment_vhgrrcaddb01" {
  count              = 4 
  managed_disk_id    = element(azurerm_managed_disk.managedisk_vhgrrcaddb01.*.id, count.index)
  virtual_machine_id = element(azurerm_virtual_machine.vm.*.id, element(var.disk_vm_vhgrrcaddb01, count.index))
  lun                = element(var.disk_attachment_lun3,count.index)
  caching            = element(var.disk_attachment_caching3,count.index)
}



///////////////////////////////////////////////////////////////////////
/////////////////////// GRUPO 2 PRODUCTIVOS ///////////////////////////

# Create network interface
resource "azurerm_network_interface" "nics_grupo2" {
  count               = 6
  name                = element(var.vm_nics_grupo2,count.index)
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "NICConfg"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "static"
    private_ip_address = element(var.vm_private_ip_grupo2,count.index)
  }
}

# Create a virtual machines 
resource "azurerm_virtual_machine" "vm2" {
  count                 = 6
  name                  = element(var.vm_names_grupo2,count.index)
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.nics_grupo2.*.id, count.index)]
  vm_size               = element(var.vm_size_grupo2,count.index)

  storage_os_disk {
    name              = element(var.vm_osdisk_name_grupo2,count.index)
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = element(var.vm_osdisk_size_grupo2,count.index)
  }

 # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = false

 # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = false

  storage_image_reference {
    publisher = element(var.image_reference_publisher2,count.index)
    offer     = element(var.vm_image_offer2,count.index)
    sku       = element(var.sku2,count.index)
    version   = "latest"
  }

  os_profile {
    computer_name  = element(var.vm_names_grupo2,count.index)
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}

# Extra disks for vhgrrpopdb01
resource "azurerm_managed_disk" "managedisk_vhgrrpopdb01" {
  count                = length(var.extradisks_vhgrrpopdb01)  
  name                 = element(var.extradisks_vhgrrpopdb01,count.index)
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = element(var.extradisks_storage_account_type4,count.index)
  create_option        = element(var.extradisks_create_option4,count.index)
  disk_size_gb         = element(var.extradisks_disk_size4,count.index)
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattachment_vhgrrpopdb01" {
  count              = 4
  managed_disk_id    = element(azurerm_managed_disk.managedisk_vhgrrpopdb01.*.id, count.index)
  virtual_machine_id = element(azurerm_virtual_machine.vm2.*.id, element(var.disk_vm_vhgrrpopdb01, count.index))
  lun                = element(var.disk_attachment_lun4,count.index)
  caching            = element(var.disk_attachment_caching4,count.index)
}

# Extra disks for vhgrrstp01
resource "azurerm_managed_disk" "managedisk_vhgrrstp01" {
  count                = length(var.extradisks_vhgrrstp01)  
  name                 = element(var.extradisks_vhgrrstp01,count.index)
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = element(var.extradisks_storage_account_type5,count.index)
  create_option        = element(var.extradisks_create_option5,count.index)
  disk_size_gb         = element(var.extradisks_disk_size5,count.index)
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattachment_vhgrrstp01" {
  count              = 4  
  managed_disk_id    = element(azurerm_managed_disk.managedisk_vhgrrstp01.*.id, count.index)
  virtual_machine_id = element(azurerm_virtual_machine.vm2.*.id, element(var.disk_vm_vhgrrstp01, count.index))
  lun                = element(var.disk_attachment_lun5,count.index)
  caching            = element(var.disk_attachment_caching5,count.index)
}

# Extra disks for vhgrrcapdb01
resource "azurerm_managed_disk" "managedisk_vhgrrcapdb01" {
  count                = length(var.extradisks_vhgrrcapdb01)  
  name                 = element(var.extradisks_vhgrrcapdb01,count.index)
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = element(var.extradisks_storage_account_type6,count.index)
  create_option        = element(var.extradisks_create_option6,count.index)
  disk_size_gb         = element(var.extradisks_disk_size6,count.index)
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattachment_vhgrrcapdb01" {
  count              = 13 
  managed_disk_id    = element(azurerm_managed_disk.managedisk_vhgrrcapdb01.*.id, count.index)
  virtual_machine_id = element(azurerm_virtual_machine.vm2.*.id, element(var.disk_vm_vhgrrcapdb01, count.index))
  lun                = element(var.disk_attachment_lun6,count.index)
  caching            = element(var.disk_attachment_caching6,count.index)
}

# Extra disks for vhgrrcapdb02
resource "azurerm_managed_disk" "managedisk_vhgrrcapdb02" {
  count                = length(var.extradisks_vhgrrcapdb02)  
  name                 = element(var.extradisks_vhgrrcapdb02,count.index)
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = element(var.extradisks_storage_account_type7,count.index)
  create_option        = element(var.extradisks_create_option7,count.index)
  disk_size_gb         = element(var.extradisks_disk_size7,count.index)
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattachment_vhgrrcapdb02" {
  count              = 8 
  managed_disk_id    = element(azurerm_managed_disk.managedisk_vhgrrcapdb02.*.id, count.index)
  virtual_machine_id = element(azurerm_virtual_machine.vm2.*.id, element(var.disk_vm_vhgrrcapdb02, count.index))
  lun                = element(var.disk_attachment_lun7,count.index)
  caching            = element(var.disk_attachment_caching7,count.index)
}




////////////////////////////////////////////////////////////
/////////////////////// DRY RUN ///////////////////////////

# Create network interface
resource "azurerm_network_interface" "nics_dry_run" {
  count               = 2
  name                = element(var.vm_nics_dry_run,count.index)
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "NICConfg"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "static"
    private_ip_address = element(var.vm_private_ip_dry_run,count.index)
  }
}

# Create a virtual machines 
resource "azurerm_virtual_machine" "vm_dry_run" {
  count                 = 2
  name                  = element(var.vm_names_dry_run,count.index)
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.nics_dry_run.*.id, count.index)]
  vm_size               = element(var.vm_size_dry_run,count.index)

  storage_os_disk {
    name              = element(var.vm_osdisk_name_dry_run,count.index)
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = element(var.vm_osdisk_size_dry_run,count.index)
  }

 # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = false

 # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = false

  storage_image_reference {
    publisher = element(var.image_reference_publisher_dry_run,count.index)
    offer     = element(var.vm_image_offer_dry_run,count.index)
    sku       = element(var.sku_dry_run,count.index)
    version   = "latest"
  }

  os_profile {
    computer_name  = element(var.vm_names_dry_run,count.index)
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}

# Extra disks for vhgrrcapdrydb01
resource "azurerm_managed_disk" "managedisk_vhgrrcapdrydb01" {
  count                = length(var.extradisks_vhgrrcapdrydb01)  
  name                 = element(var.extradisks_vhgrrcapdrydb01,count.index)
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = element(var.extradisks_storage_account_type8,count.index)
  create_option        = element(var.extradisks_create_option8,count.index)
  disk_size_gb         = element(var.extradisks_disk_size8,count.index)
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattachment_vhgrrcapdrydb01" {
  count              = 8
  managed_disk_id    = element(azurerm_managed_disk.managedisk_vhgrrcapdrydb01.*.id, count.index)
  virtual_machine_id = element(azurerm_virtual_machine.vm_dry_run.*.id, element(var.disk_vm_vhgrrcapdrydb01, count.index))
  lun                = element(var.disk_attachment_lun8,count.index)
  caching            = element(var.disk_attachment_caching8,count.index)
}
/*
////////////////////////////////////////////////////////////
/////////////////////// MONITOREO ///////////////////////////

# Create network interface
resource "azurerm_network_interface" "nic_monitoreo" {
  count               = 1    
  name                = element(var.nics_monitoreo,count.index)
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "NICConfg"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "static"
    private_ip_address = element(var.vm_private_ip_monitoreo,count.index)
  }
}

# Create a virtual machines 
resource "azurerm_virtual_machine" "vm_monitoreo" {
  count                 = 1  
  name                  = element(var.vm_names_monitoreo,count.index)
  location              = var.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.nic_monitoreo.*.id, count.index)]
  vm_size               = element(var.vm_size_monitoreo,count.index)

  storage_os_disk {
    name              = element(var.vm_osdisk_name_monitoreo,count.index)
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = element(var.vm_osdisk_size_monitoreo,count.index)
  }

 # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = false

 # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = false

  storage_image_reference {
    publisher = element(var.image_reference_publisher_monitoreo,count.index)
    offer     = element(var.vm_image_offer_monitoreo,count.index)
    sku       = element(var.sku_monitoreo,count.index)
    version   = "latest"
  }

  os_profile {
    computer_name  = element(var.vm_names_monitoreo,count.index)
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}

# Extra disks for monitoreo
resource "azurerm_managed_disk" "managedisk_monitoreo" {
  count                = length(var.extradisks_monitoreo)  
  name                 = element(var.extradisks_monitoreo,count.index)
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = element(var.extradisks_storage_account_type9,count.index)
  create_option        = element(var.extradisks_create_option9,count.index)
  disk_size_gb         = element(var.extradisks_disk_size9,count.index)
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattachment_monitoreo" {
  count              = 1
  managed_disk_id    = element(azurerm_managed_disk.managedisk_monitoreo.*.id, count.index)
  virtual_machine_id = element(azurerm_virtual_machine.vm_monitoreo.*.id, element(var.disk_vm_monitoreo, count.index))
  lun                = element(var.disk_attachment_lun9,count.index)
  caching            = element(var.disk_attachment_caching9,count.index)
}
*/