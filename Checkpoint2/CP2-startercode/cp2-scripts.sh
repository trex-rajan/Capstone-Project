#!/bin/bash

# Creating Checkpoint Resources with bash
echo "--------------------------------"
echo "Loadign the variables"
source ./config.sh
echo "Student Deafault Resource Group $RG_Name"
echo "--------------------------------"
echo 

#echo "--------------------------------"
#echo "Creating DevTest Lab"
#echo "--------------------------------"
#echo 
#source ./devtest_lab.sh CREATE

echo "--------------------------------"
echo "Creating VM from Custom Image"
echo "--------------------------------"
echo 
source ./lab_vm.sh CREATE

echo "--------------------------------"
echo "Waiting for VMs to be created"
echo "--------------------------------"
echo 
echo "Press enter key when VMs are ready"
read keypress

echo "--------------------------------"
echo "Enabling IP Forwarding"
echo "--------------------------------"
echo 
source ./nic_IP_cofig.sh NO