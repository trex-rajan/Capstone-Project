echo "Load variables from config.sh"
source ./config.sh

######################################
# if student resource group does nto exist, exit
echo "Checking status for Resource Group $RG_Name"
if [ $(az group exists --name $RG_Name) = false ]; then
    echo "Resource Group $RG_Name does not exist"
    exit
fi

echo "--------------------------------"
echo "list current vm images in $DevTest_Lab"
echo "--------------------------------"
echo

command=$1
version=$2

# if version parameter is not provided, exit with erro 2
if [ $version -eq 0 ]
  then
    echo "version is null "
    echo "You must supply version"
    echo "program will abort with error 2 in here"
    exit 2
fi

if [[ "$command" == "SHOW" ]]; then
######################################
#Show Custom Image
echo "----------------------"
echo "Running Next ---------"
echo "Showing image information"
for image in "${image_list[@]}"
do
    echo "Showing --> $image-v$version"
    echo "$image-v$version"
    echo
    az lab custom-image show --lab-name $DevTest_Lab --name "$image-v$version" --resource-group $RG_Name &
done

elif [[ "$command" == "DELETE" ]]; then
######################################
#Delete Custom Image
echo "----------------------"
echo "Running Next ---------"
echo "Deleting image"
for image in "${image_list[@]}"
do
    echo "Deleting --> $image-v$version"
    az lab custom-image delete --lab-name $DevTest_Lab --name "$image-v$version" --resource-group $RG_Name &
done

elif [[ "$command" == "CREATE" ]]; then
######################################
#Create Custom Image
echo "----------------------"
echo "Running Next ---------"
echo "Creating image"
for image in "${image_list[@]}"
do
    OS_TYPE="Linux"
    OS_STATE="NonDeprovisioned"
    if [[ "$image" == "$VM_WS" || "$image" == "$VM_WC" ]]; then
        OS_TYPE="Windows"
        OS_STATE="NonSysprepped"
    fi
    echo "$OS_TYPE"
    echo "Creating --> $image-v$version"
    az lab custom-image create --lab-name $DevTest_Lab --name "$image-v$version" --resource-group $RG_Name \
        --os-type $OS_TYPE --os-state $OS_STATE \
        --source-vm-id /subscriptions/$Sub_ID/resourcegroups/$RG_Name/providers/microsoft.devtestlab/labs/$DevTest_Lab/virtualmachines/$image &
done

# az lab custom-image create --lab-name CSN500-120 --name lr-120-5 --resource-group  student-rg-634489 --os-type Linux --os-state NonDeprovisioned \
# --source-vm-id /subscriptions/d4a883dd-79d7-45fd-ad66-297181dd5dc4/resourcegroups/student-rg-634489/providers/microsoft.devtestlab/labs/csn500-120/virtualmachines/LR-120

else
######################################
#Start VM
echo "----------------------"
echo "No operation done"
echo "usage ./lab_vm_op.sh argument"
echo "valid arguments: SHOW, DELETE, CREATE"
fi
