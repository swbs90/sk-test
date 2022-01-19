# =================== #
# Deploying VMware VM #
# =================== #

# Connect to VMware vSphere vCenter
provider "vsphere" {
user = var.vsphere-user
password = var.vsphere-password
vsphere_server = var.vsphere-vcenter

# If you have a self-signed cert
allow_unverified_ssl = var.vsphere-unverified-ssl
}

# Define VMware vSphere
data "vsphere_datacenter" "dc" {
name = var.vsphere-datacenter
}

data "vsphere_datastore" "datastore" {
name = var.vm-datastore
datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
name = var.vsphere-cluster
datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_virtual_machine" "template" {
name = "/${var.vsphere-datacenter}/vm/${var.vsphere-template-folder}/${var.vm-template-name}"
datacenter_id = data.vsphere_datacenter.dc.id 
} 

#data "vsphere_distributed_virtual_switch" "dvs"{
#name = var.vm-dvs
#datacenter_id = data.vsphere_datacenter.dc.id
#}

#resource "vsphere_distributed_port_group" "pg"{
#name = var.vm-pg
#distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.dvs.id

###active_uplinks = data.vsphere_distributed_virtual_switch.dvs.uplinks[0] //뭐가 다른거?;;
#active_uplinks  = ["${data.vsphere_distributed_virtual_switch.dvs.uplinks[0]}"]

#}

data "vsphere_network" "network" {
name = var.vm-network
datacenter_id = data.vsphere_datacenter.dc.id
depends_on = [vsphere_distributed_port_group.pg]
}

#data "vsphere_vnic" "vnic" {
#  name = var.vm-nic
#  portgroup = vsphere_host_port_group.p1.name
#  ipv4 {
#    dhcp = false
#  }

# Create VMs
resource "vsphere_virtual_machine" "vm" {
count = var.vm-count
name = var.vm-name
#firmware = var.vm-firmware
resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
datastore_id = data.vsphere_datastore.datastore.id
num_cpus = var.vm-cpu
memory = var.vm-ram
guest_id = var.vm-guest-id
##wait_for_guest_net_routable = false
#wait_for_guest_net_timeout = 0
#wait_for_guest_ip_timeout  = 0
network_interface {
  network_id = data.vsphere_network.network.id
}

disk {
  label = "${var.vm-name}-disk"
  size  = var.vm-disk
}

clone {
  template_uuid = data.vsphere_virtual_machine.template.id
  customize {
    timeout = 0
    #wait_for_guest_net_timeout = 0

    linux_options {
      host_name = var.vm-name
      domain = "test.internal"
    }
  
    network_interface {
       ipv4_address    = "${var.vm-ipv4}"
       ipv4_netmask    = "${var.vm-netmask}" 
       #dns_server_list = ["8.8.8.8", "8.8.4.4"]
      }

    #  ipv4_gateway = "${var.vm-gw4}"
  }
 }
}
