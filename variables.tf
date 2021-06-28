variable "location" {}

variable "admin_username" {
  type        = string
  description = "Administrator user name for virtual machine"
}

variable "admin_password" {
  type        = string
  description = "Password must meet Azure complexity requirements"
}

////////////////// Group 1 No Productivo ///////////////////
variable "vm_private_ip_grupo1" {
  default = ["192.168.92.11", "192.168.92.12", "192.168.92.13", "192.168.92.14", "192.168.92.15", "192.168.92.16", "192.168.92.17", "192.168.92.18", "192.168.92.19" ]
}

variable "vm_nics_grupo1" {
  default = ["nicvhgrrcadapp01", "nicvhgrrcaqapp01", "nicvhgrrpoddb01", "nicvhgrrpodapp01", "nicvhgrrwdd01", "nicvhgrrwdp01", "nicvhgrrwdp02", "nicvhgrrcaqdb01", "nicvhgrrcaddb01"]
}

variable "vm_names_grupo1" {
  default = ["vhgrrcadapp01", "vhgrrcaqapp01", "vhgrrpoddb01", "vhgrrpodapp01", "vhgrrwdd01", "vhgrrwdp01", "vhgrrwdp02", "vhgrrcaqdb01", "vhgrrcaddb01"]
}

variable "vm_size_grupo1" {
  default = ["Standard_E4ds_v4", "Standard_E8ds_v4", "Standard_E4ds_v4", "Standard_E2ds_v4", "Standard_E2ds_v4", "Standard_E2ds_v4", "Standard_E2ds_v4", "Standard_M64ms", "Standard_E16ds_v4"]    
}

variable "vm_osdisk_name_grupo1" {
  default = ["osDisk_vhgrrcadapp01", "osDisk_vhgrrcaqapp01", "osDisk_vhgrrpoddb01", "osDisk_vhgrrpodapp01", "osDisk_vhgrrwdd01", "osDisk_vhgrrwdp01", "osDisk_vhgrrwdp02", "osDisk_vhgrrcaqdb01", "osDisk_vhgrrcaddb01"]    
}

variable "vm_osdisk_size_grupo1" {
  default = ["256", "256", "128", "256", "256", "256", "256", "512", "512"]    
}

variable "image_reference_publisher" {
  default = ["suse", "suse", "suse", "suse", "suse", "suse", "suse", "suse", "suse"]
}

variable "vm_image_offer" {
  default = ["sles-15-sp2-basic", "sles-15-sp2-basic", "sles-15-sp2-basic", "sles-15-sp2-basic", "sles-15-sp2-basic", "sles-15-sp2-basic", "sles-15-sp2-basic", "sles-15-sp2-basic", "sles-15-sp2-basic"]
}

variable "sku" {
  default = ["gen1", "gen1", "gen1", "gen1", "gen1", "gen1", "gen1", "gen1", "gen1"]
}

# Extra disks for vhgrrpoddb01
variable "extradisks_vhgrrpoddb01" {
  default = ["disk_bins_vhgrrpoddb01", "disk_data_vhgrrpoddb01", "disk_log_vhgrrpoddb01", "disk_backup_vhgrrpoddb01"]
}

variable "extradisks_storage_account_type1" {
  default = ["Premium_LRS", "Premium_LRS", "Premium_LRS", "Standard_LRS"]
}

variable "extradisks_create_option1" {
  default = ["Empty", "Empty", "Empty", "Empty"]
}

variable "extradisks_disk_size1" {
  default = ["128", "128", "32", "1024"]
}

variable "disk_vm_vhgrrpoddb01" {
  default = ["2"]
}

variable "disk_attachment_lun1" {
  default = ["0", "1", "2", "3"]
}

variable "disk_attachment_caching1" {
  default = ["None", "None", "None", "None"]
}

# Extra disks for vhgrrcaqdb01
variable "extradisks_vhgrrcaqdb01" {
  default = ["disk_hana_shared_vhgrrcaqdb01", "disk_data1_vhgrrcaqdb01", "disk_data2_vhgrrcaqdb01", "disk_data3_vhgrrcaqdb01", "disk_data4_vhgrrcaqdb01", "disk_log_vhgrrcaqdb01", "disk_backup1_vhgrrcaqdb01", "disk_backup2_vhgrrcaqdb01", "disk_backup3_vhgrrcaqdb01", "disk_backup4_vhgrrcaqdb01", "disk_backup5_vhgrrcaqdb01"]
}

variable "extradisks_storage_account_type2" {
  default = ["Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Standard_LRS", "Standard_LRS", "Standard_LRS", "Standard_LRS", "Standard_LRS"]
}

variable "extradisks_create_option2" {
  default = ["Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
}

variable "extradisks_disk_size2" {
  default = ["512", "512", "512", "512", "512", "512", "4096", "4096", "4096", "4096", "4096"]
}

variable "disk_vm_vhgrrcaqdb01" {
  default = ["7"]
}

variable "disk_attachment_lun2" {
  default = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
}

variable "disk_attachment_caching2" {
  default = ["None", "None", "None", "None", "None", "None", "None", "None", "None", "None", "None"]
}

# Extra disks for vhgrrcaddb01
variable "extradisks_vhgrrcaddb01" {
  default = ["disk_hana_shared_vhgrrcaddb01", "disk_data_vhgrrcaddb01", "disk_log_vhgrrcaddb01", "disk_backup_vhgrrcaddb01"]
}

variable "extradisks_storage_account_type3" {
  default = ["Premium_LRS", "Premium_LRS", "Premium_LRS", "Standard_LRS"]
}

variable "extradisks_create_option3" {
  default = ["Empty", "Empty", "Empty", "Empty"]
}

variable "extradisks_disk_size3" {
  default = ["512", "128", "128", "2048"]
}

variable "disk_vm_vhgrrcaddb01" {
  default = ["8"]
}

variable "disk_attachment_lun3" {
  default = ["0", "1", "2", "3"]
}

variable "disk_attachment_caching3" {
  default = ["None", "None", "None", "None"]
}

///////////////////////////////////////////////////////////////////////
///////////////////////// GRUPO 2 PRODUCTIVOS /////////////////////////

variable "vm_private_ip_grupo2" {
  default = ["192.168.92.21", "192.168.92.22", "192.168.92.23", "192.168.92.24", "192.168.92.25", "192.168.92.26"]
}

variable "vm_nics_grupo2" {
  default = ["nicvhgrrcapapp01", "nicvhgrrpopdb01", "nicvhgrrpopapp01", "nicvhgrrstp01", "nicvhgrrcapdb01", "nicvhgrrcapdb02"]
}

variable "vm_names_grupo2" {
  default = ["vhgrrcapapp01", "vhgrrpopdb01", "vhgrrpopapp01", "vhgrrstp01", "vhgrrcapdb01", "vhgrrcapdb02"]
}

variable "vm_size_grupo2" {
  default = ["Standard_E8ds_v4", "Standard_E4ds_v4", "Standard_E4ds_v4", "Standard_E8ds_v4", "Standard_M64ms", "Standard_M64ms"]    
}

variable "vm_osdisk_name_grupo2" {
  default = ["osDisk_vhgrrcapapp01", "osDisk_vhgrrpopdb01", "osDisk_vhgrrpopapp01", "osDisk_vhgrrstp01", "osDisk_vhgrrcapdb01", "osDisk_vhgrrcapdb02"]    
}

variable "vm_osdisk_size_grupo2" {
  default = ["256", "128", "256", "256", "512", "512"]    
}

variable "image_reference_publisher2" {
  default = ["suse", "suse", "suse", "suse", "suse", "suse"]
}

variable "vm_image_offer2" {
  default = ["sles-sap-15-sp2", "sles-sap-15-sp2", "sles-sap-15-sp2", "sles-sap-15-sp2", "sles-sap-15-sp2", "sles-sap-15-sp2"]
}

variable "sku2" {
  default = ["gen1", "gen1", "gen1", "gen1", "gen2", "gen2"]
}

# Extra disks for vhgrrpopdb01
variable "extradisks_vhgrrpopdb01" {
  default = ["disk_bins_vhgrrpopdb01", "disk_data_vhgrrpopdb01", "disk_log_vhgrrpopdb01", "disk_backup_vhgrrpopdb01"]
}

variable "extradisks_storage_account_type4" {
  default = ["Premium_LRS", "Premium_LRS", "Premium_LRS", "Standard_LRS"]
}

variable "extradisks_create_option4" {
  default = ["Empty", "Empty", "Empty", "Empty"]
}

variable "extradisks_disk_size4" {
  default = ["128", "128", "32", "1024"]
}

variable "disk_vm_vhgrrpopdb01" {
  default = ["1"]
}

variable "disk_attachment_lun4" {
  default = ["0", "1", "2", "3"]
}

variable "disk_attachment_caching4" {
  default = ["None", "None", "None", "None"]
}

# Extra disks for vhgrrstp01
variable "extradisks_vhgrrstp01" {
  default = ["disk_bins_vhgrrstp01", "disk_data_vhgrrstp01", "disk_log_vhgrrstp01", "disk_backup_vhgrrstp01"]
}

variable "extradisks_storage_account_type5" {
  default = ["Premium_LRS", "Premium_LRS", "Premium_LRS", "Standard_LRS"]
}

variable "extradisks_create_option5" {
  default = ["Empty", "Empty", "Empty", "Empty"]
}

variable "extradisks_disk_size5" {
  default = ["128", "128", "32", "1024"]
}

variable "disk_vm_vhgrrstp01" {
  default = ["3"]
}

variable "disk_attachment_lun5" {
  default = ["0", "1", "2", "3"]
}

variable "disk_attachment_caching5" {
  default = ["None", "None", "None", "None"]
}

# Extra disks for vhgrrcapdb01
variable "extradisks_vhgrrcapdb01" {
  default = ["disk1_hana_shared_vhgrrcapdb01", "disk2_hana_shared_vhgrrcapdb01", "disk_data1_vhgrrcapdb01", "disk_data2_vhgrrcapdb01", "disk_data3_vhgrrcapdb01", "disk_data4_vhgrrcapdb01", "disk_data5_vhgrrcapdb01", "disk_log_vhgrrcapdb01", "disk_backup1_vhgrrcapdb01", "disk_backup2_vhgrrcapdb01", "disk_backup3_vhgrrcapdb01", "disk_backup4_vhgrrcapdb01", "disk_backup5_vhgrrcapdb01"]
}

variable "extradisks_storage_account_type6" {
  default = ["Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Standard_LRS", "Standard_LRS", "Standard_LRS", "Standard_LRS", "Standard_LRS" ]
}

variable "extradisks_create_option6" {
  default = ["Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
}

variable "extradisks_disk_size6" {
  default = ["512", "512", "512", "512", "512", "512", "512", "512", "4096", "4096", "4096", "4096", "4096"]
}

variable "disk_vm_vhgrrcapdb01" {
  default = ["4"]
}

variable "disk_attachment_lun6" {
  default = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
}

variable "disk_attachment_caching6" {
  default = ["None", "None", "None", "None", "None", "None", "None", "None", "None", "None", "None", "None", "None"]
}

# Extra disks for vhgrrcapdb02
variable "extradisks_vhgrrcapdb02" {
  default = ["disk1_hana_shared_vhgrrcapdb02", "disk2_hana_shared_vhgrrcapdb02", "disk_data1_vhgrrcapdb02", "disk_data2_vhgrrcapdb02", "disk_data3_vhgrrcapdb02", "disk_data4_vhgrrcapdb02", "disk_data5_vhgrrcapdb02", "disk_log_vhgrrcapdb02"]
}

variable "extradisks_storage_account_type7" {
  default = ["Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS"]
}

variable "extradisks_create_option7" {
  default = ["Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
}

variable "extradisks_disk_size7" {
  default = ["512", "512", "512", "512", "512", "512", "512", "512"]
}

variable "disk_vm_vhgrrcapdb02" {
  default = ["5"]
}

variable "disk_attachment_lun7" {
  default = ["0", "1", "2", "3", "4", "5", "6", "7"]
}

variable "disk_attachment_caching7" {
  default = ["None", "None", "None", "None", "None", "None", "None", "None"]
}

////////////////////////////////////////////////////////////
/////////////////////// DRY RUN ///////////////////////////

variable "vm_private_ip_dry_run" {
  default = ["192.168.92.31", "192.168.92.32"]
}

variable "vm_nics_dry_run" {
  default = ["nicvhgrrcapdry01", "nicvhgrrcapdrydb01"]
}

variable "vm_names_dry_run" {
  default = ["vhgrrcapdry01", "vhgrrcapdrydb01"]
}

variable "vm_size_dry_run" {
  default = ["Standard_E8ds_v4", "Standard_M64ms"]    
}

variable "vm_osdisk_name_dry_run" {
  default = ["osDisk_vhgrrcapdry01", "osDisk_vhgrrcapdrydb01"]    
}

variable "vm_osdisk_size_dry_run" {
  default = ["256", "512"]    
}

variable "image_reference_publisher_dry_run" {
  default = ["suse", "suse"]
}

variable "vm_image_offer_dry_run" {
  default = ["sles-sap-15-sp2", "sles-sap-15-sp2"]
}

variable "sku_dry_run" {
  default = ["gen1", "gen1"]
}

# Extra disks for vhgrrcapdrydb01
variable "extradisks_vhgrrcapdrydb01" {
  default = ["disk1_hana_shared_vhgrrcapdrydb01", "disk2_hana_shared_vhgrrcapdrydb01", "disk_data1_vhgrrcapdrydb01", "disk_data2_vhgrrcapdrydb01", "disk_data3_vhgrrcapdrydb01", "disk_data4_vhgrrcapdrydb01", "disk_data5_vhgrrcapdrydb01", "disk_log_vhgrrcapdrydb01"]
}

variable "extradisks_storage_account_type8" {
  default = ["Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS", "Premium_LRS"]
}

variable "extradisks_create_option8" {
  default = ["Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty", "Empty"]
}

variable "extradisks_disk_size8" {
  default = ["512", "512", "512", "512", "512", "512", "512", "512"]
}

variable "disk_vm_vhgrrcapdrydb01" {
  default = ["1"]
}

variable "disk_attachment_lun8" {
  default = ["0", "1", "2", "3", "4", "5", "6", "7"]
}

variable "disk_attachment_caching8" {
  default = ["None", "None", "None", "None", "None", "None", "None", "None"]
}

////////////////////////////////////////////////////////////
/////////////////////// MONITOREO ///////////////////////////

variable "vm_private_ip_monitoreo" {
  default = ["192.168.92.50"]
}

variable "nics_monitoreo" {
  default = ["nicmonitoreo"]
}

variable "vm_names_monitoreo" {
  default = ["controlit-gw"]
}

variable "vm_size_monitoreo" {
  default = ["Standard_B1ms"]    
}

variable "vm_osdisk_name_monitoreo" {
  default = ["osDisk_controlit-gw"]    
}

variable "vm_osdisk_size_monitoreo" {
  default = ["128"]    
}

variable "image_reference_publisher_monitoreo" {
  default = ["cognosys"]
}

variable "vm_image_offer_monitoreo" {
  default = ["centos-7-8-free"]
}

variable "sku_monitoreo" {
  default = ["centos-7-8-free"]
}

# Extra disks for monitoreo
variable "extradisks_monitoreo" {
  default = ["disk1_monitoreo", "disk2_monitoreo"]
}

variable "extradisks_storage_account_type9" {
  default = ["Standard_LRS", "Standard_LRS"]
}

variable "extradisks_create_option9" {
  default = ["Empty", "Empty"]
}

variable "extradisks_disk_size9" {
  default = ["128", "32"]
}

variable "disk_vm_monitoreo" {
  default = ["0"]
}

variable "disk_attachment_lun9" {
  default = ["0", "1"]
}

variable "disk_attachment_caching9" {
  default = ["None", "None"]
}