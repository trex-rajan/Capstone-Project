# Variable block

# Checkpoint1 Resources
Location="Canada East"
RG_Name="Student-RG-????"
Sub_ID="?????"
Student_vnet="Student-??????-vnet"
Router_vnet="Router-???"
Server_vnet="Server-???"
SubNet="SN1"
RT_Name="RT-???"
Client_SN="Virtual-Desktop-Client"
Virtual_Appliance="192.168.???.36"
Server_SN1="172.17.???.32/27"
Virtual_Desktop="???"
DevTest_Lab="CSN400-???"

Peer_RT="RoutertoStudent"
Peer_TR="StudenttoRouter"
Peer_RS="RoutertoServer"
Peer_SR="ServertoRouter"

Route_Server="Route-Server"
Route_Client="Route-Desktop"

#Checkpoint2 VM names
VM_WC="WC-???"
VM_WS="WS-???"
VM_LR="LR-???"
VM_LS="LS-???"

#Checkpoint3 Static IP setting
Static_LR="192.168.???.36"
Static_WS="172.17.???.36"
Static_LS="172.17.???.37"
dummy_IP_1="172.17.???.41"
dummy_IP_2="172.17.???.42"
NIC_LR="lr-???"
NIC_LS="ls-???"
NIC_WS="ws-???"
NIC_WC="wc-???"
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
declare -a subnets_rvnet=("192.168.xxx.32/27" "192.168.xxx.64/27" "192.168.xxx.96/27" "192.xxx.120.128/27")
declare -a subnets_svnet=("172.17.xxx.32/27" "172.17.xxx.64/27" "172.17.xxx.96/27" "172.17.xxx.128/27")
