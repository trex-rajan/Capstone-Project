#!/bin/bash

# Creating Checkpoint Resources with bash
echo "--------------------------------"
echo "Loadign the variables"
source ./config.sh
echo "Student Deafault Resource Group $RG_Name"
echo "--------------------------------"
echo 

echo "--------------------------------"
echo "Creating VNETs"
echo "--------------------------------"
echo 
source ./vnet.sh CREATE

echo "--------------------------------"
echo "Creating Route Tables"
echo "--------------------------------"
echo 
source ./route_table.sh CREATE
