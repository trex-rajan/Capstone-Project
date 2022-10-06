# Creating Checkpoint1 Resources with bash

# echo "Load variables from config.sh"
source ./config.sh

######################################
# if student resource group does nto exist, exit
echo "Checking status for Resource Group $RG_Name"
if [ $(az group exists --name $RG_Name) = false ]; then
    echo "Resource Group $RG_Name does not exist"
    exit
fi

command=$1

if [[ "$command" == "SCRIPTED" ]]; then
######################################
#Route-Table Creation from CLI (no template)
echo "----------------------"
echo "Creating Route Table: $RT_Name"
echo "Check if it already exists"
if [[ $(az network route-table list --resource-group $RG_Name --query "[?name=='$RT_Name'] | length(@)") > 0 ]]; then
        echo "exists"
        az network route-table show --resource-group $RG_Name --name $RT_Name --query id 
else
    echo "Creating Ruote Table: $RT_Name"
    az network route-table create --resource-group $RG_Name --name $RT_Name
    if [[ $(az network route-table list --resource-group $RG_Name --query "[?name=='$RT_Name'] | length(@)") > 0 ]]; then
           echo "Completed ----"
           az network route-table show --resource-group $RG_Name --name $RT_Name --query id
    else
           echo "Failed resource creation, aborting ----"
           exit 3
    fi
fi

az network route-table route create -g $RG_Name --route-table-name $RT_Name -n $Route_Server --next-hop-type VirtualAppliance --address-prefix $Server_SN1 --next-hop-ip-address $Virtual_Appliance
az network route-table route create -g $RG_Name --route-table-name $RT_Name -n $Route_Client --next-hop-type VirtualAppliance --address-prefix $Virtual_Desktop --next-hop-ip-address $Virtual_Appliance

elif [[ "$command" == "CREATE" ]]; then
######################################
#Route Table creation and subnet association 
echo "----------------------"
echo "Running Next ---------"
echo "az deployment group create --resource-group $RG_Name --template-file ./RouteTable/template.json"
az deployment group create --resource-group $RG_Name --template-file ./RouteTable/template.json 
echo "Completed ------------"

######################################
#Route Table Route Create
echo "----------------------"
echo "Running Next ---------"
echo "Creating Routes"
az network route-table route create -g $RG_Name --route-table-name $RT_Name -n $Route_Server \
    --next-hop-type VirtualAppliance --address-prefix $Server_SN1 --next-hop-ip-address $Virtual_Appliance
az network route-table route create -g $RG_Name --route-table-name $RT_Name -n $Route_Client \
    --next-hop-type VirtualAppliance --address-prefix $Virtual_Desktop --next-hop-ip-address $Virtual_Appliance

######################################
#Route Tables Routes Associate
echo "----------------------"
echo "Running Next ---------"
echo "Creating Route Associations"
az network vnet subnet update -n $SubNet --vnet-name $Server_vnet -g $RG_Name --route-table $RT_Name
az network vnet subnet update -n $Client_SN --vnet-name $Student_vnet -g $RG_Name --route-table $RT_Name


elif [[ "$command" == "CREATE" ]]; then
######################################
#Route Tables Routes Dis-associate
echo "----------------------"
echo "Running Next ---------"
echo "Removing Route Associations"
az network vnet subnet update -n $SubNet --vnet-name $Server_vnet -g $RG_Name --route-table $RT_Name
az network vnet subnet update -n $Client_SN --vnet-name $Student_vnet -g $RG_Name --route-table $RT_Name

######################################
#Route Table Route Delete
echo "----------------------"
echo "Running Next ---------"
echo "Deleting Routes"
az network route-table route delete -g $RG_Name --route-table-name $RT_Name -n $Route_Server
az network route-table route delete -g $RG_Name --route-table-name $RT_Name -n $Route_Client

######################################
#Route Table Deletion
echo "----------------------"
echo "Running Next ---------"
echo "Deleting Route-Table"
az network route-table delete -g $RG_Name --name $RT_Name
echo "Completed ------------" 

else
######################################
echo "----------------------"
echo "No operation done"
echo "usage ./route_table.sh argument"
echo "valid arguments: CREATE, DELETE"
fi