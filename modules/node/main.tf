
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

# Point to specific or many datatstores
# https://www.terraform.io/docs/providers/vsphere/d/datastore.html
# *************************************************************
data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Point to specific computer (blade) clusters or pool
# https://www.terraform.io/docs/providers/vsphere/r/compute_cluster.html
# *************************************************************
data "vsphere_compute_cluster" "pool" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Point to specific network to use
# https://www.terraform.io/docs/providers/vsphere/d/network.html
# *************************************************************
data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Setting the template to be used
# https://www.terraform.io/docs/providers/vsphere/r/virtual_machine.html
# *************************************************************
data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_template
  datacenter_id = data.vsphere_datacenter.dc.id
}


resource "vsphere_virtual_machine" "vm" {
  count                = var.vm_count
  name                 = "${var.name_prefix}-${format("%03d", count.index + 1)}"
  folder               = var.vsphere_folder
  resource_pool_id     = data.vsphere_compute_cluster.pool.resource_pool_id
  datastore_id         = data.vsphere_datastore.datastore.id
  memory               = var.ram_count
  guest_id             = data.vsphere_virtual_machine.template.guest_id
  scsi_type            = data.vsphere_virtual_machine.template.scsi_type
  sync_time_with_host  = false
 
  # Annotations Block for build notes in vsphere
  # https://www.terraform.io/docs/providers/vsphere/r/virtual_machine.html#annotation
  # *************************************************************
  annotation = "Time of Creation: ${timestamp()} | Original Specifications: RAM(${var.ram_count} MB), DISK(${var.disk_size} GB) | Template Used for build: ${var.vsphere_template}"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = var.disk_size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
  }

  # http  # Clone from Template
  # www.terraform.io/docs/providers/vsphere/r/virtual_machine.html#creating-a-virtual-machine-from-a-template

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      network_interface {}
      linux_options {
        host_name = "${var.name_prefix}-${format("%03d", count.index + 1)}"
        domain = var.domain_ou
      }
    }

  }
}
