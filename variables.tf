#===========================#
# VMware vCenter connection #
#===========================#

variable "vsphere-user" {
type = string 
description = "vCenter/vSphere 계정"
}  

variable "vsphere-password" {
type = string
description = "vCenter/vSphere 패스워드"
}

variable "vsphere-vcenter" {
type = string
description = "vCenter/vSphere 서버 FQDN / IP"
default = "172.21.0.200"
}

variable "vsphere-unverified-ssl" {
type = string
description = "자체 서명 된 인증서를 사용하는 VMware vCenter (true / false)"
default = true
}

variable "vsphere-datacenter" {
type = string
description = "VMWare vSphere datacenter 이름"
default = "Datacenter"
}

variable "vsphere-cluster" {
type = string
description = "VMWare vSphere cluster 이름"
default = "CN-CL"
}

variable "vsphere-template-folder" {
type = string
description = "Template folder 이름"
default = "template-folder"
}

#================================#
# VMware vSphere virtual machine #
#================================#

variable "vm-count" {
type = string
description = "생성 할 VM 갯수"
default =  1
}

variable "vm-datastore" {
type = string
description = "VMWare vSphere datastore 이름"
default = "datastore1"
}

variable "vm-network" {
type = string
description = "VMWare vSphere Network 이름"
default = "172.21.4.1%2f23"
}

variable "vm-cpu" {
type = string
description = "가상머신 CPU 개수"
default = "1"
}

variable "vm-ram" {
type = string
description = "가상머신 Memory 사이즈"
default = "2048"
}

variable "vm-disk" {
type = string
description = "가상머신 Disk 사이즈"
default = "30"
}

variable "vm-name" {
type = string
description = "가상머신 이름"
}

#variable "vm-firmware" {
#type = string
#description = "가상머신 fireware set (efi / bios)"
#default = "efi"
#}

variable "vm-guest-id" {
type = string
description = "가상머신 OS명"
default = "rhel7_64Guest"
}

variable "vm-template-name" {
type = string
description = "가상머신을 배포할 템플릿 이름"
default = "이승은 - redhat_packer"
}

variable "vm-dvs"{
type = string
description = "분산 스위치"
default = "vDSwitch-Eth2"
}

variable "vm-pg"{
type = string
description = "분산 스위치 포트그룹"
default = "sk-pg-48"
}

variable "vm-ipv4"{
type = string
description = "ipv4 address"
default = "172.21.4.48"
}

variable "vm-netmask"{
type = string
description = "netmask"
default = "24"
}

variable "vm-gw4"{
type = string
description = "gateway"
default = "172.21.4.1"
}
