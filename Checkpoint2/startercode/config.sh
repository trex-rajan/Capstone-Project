# Variable block

# Checkpoint1 Resources
Location="Canada East"
RG_Name="Student-RG-????"
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

Route_Server="Router-Server"
Route_Client="Router-Desktop"

Router_vnet_prefix="192.168.52.0/24"
Server_vnet_prefix="172.17.52.0/24"

#Checkpoint2 VM names
VM_WC="WC-52"
VM_WS="WS-52"
VM_LR="LR-52"
VM_LS="LS-52"

#Checkpoint3 Static IP setting
Static_LR="192.168.???.36"
Static_WS="172.17.???.36"
Static_LS="172.17.???.37"
dummy_IP_1="172.17.???.41"
dummy_IP_2="172.17.???.42"
NIC_LR="lr-52"
NIC_LS="ls-52"
NIC_WS="ws-52"
NIC_WC="wc-52"
Azure_Default_DNS="???"