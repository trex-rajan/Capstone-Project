# Creating Checkpoint1 Resources with bash

echo "Load variables from config.sh"
source ./config.sh

######################################
# if student resource group does nto exist, exit
echo "Checking status for Resource Group $RG_Name"
if [ $(az group exists --name $RG_Name) = false ]; then
    echo "Resource Group $RG_Name does not exist"
    exit
fi

command=$1

if [[ "$command" == "STOP" ]]; then
######################################
#Stop Running VM
echo "----------------------"
echo "Running Next ---------"
echo "Stopping VMs"
for vm in "${vm_list[@]}"
do
    echo "Stopping --> $vm"
    az lab vm stop --lab-name $DevTest_Lab --name $vm --resource-group $RG_Name &
done

elif [[ "$command" == "DELETE" ]]; then
######################################
#Delete VM
echo "----------------------"
echo "Running Next ---------"
echo "Deleting VMs"
for vm in "${vm_list[@]}"
do
    echo "Deleting --> $vm"
    az lab vm delete --lab-name $DevTest_Lab --name $vm --resource-group $RG_Name &
done

elif [[ "$command" == "START" ]]; then
######################################
#Start VM
echo "----------------------"
echo "Running Next ---------"
echo "Starting VMs"
for vm in "${vm_list[@]}"
do
    echo "Starting --> $vm"
    az lab vm start --lab-name $DevTest_Lab --name $vm --resource-group $RG_Name &
done

elif [[ "$command" == "CREATE" ]]; then
######################################
#Virtual Machine Deployment 
echo "----------------------"
echo "Running Next ---------"
echo " Deploying VMs"
for json in "${json_list[@]}"
do
    echo "deploying --> $json"
    az deployment group create --resource-group $RG_Name --template-file ./DevTestLab/$json --no-wait
done

else
######################################
#Start VM
echo "----------------------"
echo "No operation done"
echo "usage ./lab_vm_op.sh argument"
echo "valid arguments: START, STOP, DELETE"
fi