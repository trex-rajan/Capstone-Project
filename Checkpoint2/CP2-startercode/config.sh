# Variable block

# Checkpoint1 Resources
Location="Canada East"
RG_Name="Student-RG-734707"
Sub_ID="e22a2bd0-d760-4866-9918-1c98f501eb6a"
Student_vnet="Student-734707-vnet"
Router_vnet="Router-52"
Server_vnet="Server-52"
SubNet="SN1"
RT_Name="RT-52"
Client_SN="Virtual-Desktop-Client"
Virtual_Appliance="192.168.52.36"
Server_SN1="172.17.52.32/27"
Virtual_Desktop="10.11.119.0/24"
DevTest_Lab="CSN400-52"

Peer_RT="RoutertoStudent"
Peer_TR="StudenttoRouter"
Peer_RS="RoutertoServer"
Peer_SR="ServertoRouter"

Route_Server="Route-Server"
Route_Client="Route-Desktop"

#Checkpoint2 VM names
VM_WC="WC-52"
VM_WS="WS-52"
VM_LR="LR-52"
VM_LS="LS-52"

#Checkpoint3 Static IP setting
Static_LR="192.168.52.36"
Static_WS="172.17.52.36"
Static_LS="172.17.52.37"
dummy_IP_1="172.17.52.41"
dummy_IP_2="172.17.52.42"
NIC_LR="lr-52"
NIC_LS="ls-52"
NIC_WS="ws-52"
NIC_WC="wc-52"
Azure_Default_DNS="???"


declare -a vm_list=("$VM_WS" "$VM_WC" "$VM_LR" "$VM_LS")
declare -a json_list=("ws.json" "wc.json" "lr.json" "ls.json")
declare -a image_list=("$VM_WS" "$VM_WC" "$VM_LR" "$VM_LS")
declare -a windowslist=("$VM_WS" "$VM_WC")
declare -a linux_list=("$VM_LR" "$VM_LS")
declare -a vnet_list=("$Server_vnet" "$Router_vnet" "$Student_vnet")
declare -a v_list=("$Server_vnet" "$Router_vnet")
declare -a nic_list=("$NIC_LR" "$NIC_LS" "$NIC_WS" "$NIC_WC")
declare -a peer_list=("$Peer_RT" "$Peer_TR" "$Peer_RS" "$Peer_SR")
declare -a route_list=("$Route_Server" "$Route_Client")
declare -a subnets_rvnet=("192.168.52.32/27" "192.168.52.64/27" "192.168.52.96/27" "192.52.120.128/27")
declare -a subnets_svnet=("172.17.52.32/27" "172.17.52.64/27" "172.17.52.96/27" "172.17.52.128/27")
