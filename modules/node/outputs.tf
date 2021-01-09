# here is a better version but we need to sort out the list with numberic index problem first
output "nodes" {
  value = [
    for index, node in vsphere_virtual_machine.vm :
    {
      name = node.name
      ip   = node.default_ip_address
    }
  ]
}

# currently we only use nodes , not nodes_ip 
output "nodes_ip" {
  value = vsphere_virtual_machine.vm.*.default_ip_address
}
