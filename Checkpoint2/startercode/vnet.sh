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
#VNET Creation from CLI (no template)
for vnet in "${v_list[@]}"
do
   echo "----------------------"
   echo "Creating VNET: $vnet"
   echo "Check if it already exists"
   if [[ $(az network vnet list --resource-group $RG_Name --query "[?name=='$vnet'] | length(@)") > 0 ]]
   then
        echo "exists"
        az network vnet show --resource-group $RG_Name --name $vnet --query id 
   else 
        default_location=$(az group show --name $RG_Name --query location)
        def_location=${default_location//\"}
        if [[ $vnet == $Server_vnet ]]; then
           prefix=$Server_vnet_prefix
        elif [[ $vnet == $Router_vnet ]]; then 
           prefix=$Router_vnet_prefix
        fi
        az network vnet create --resource-group $RG_Name --name $vnet --location $def_location --address-prefix $prefix
        if [[ $(az network vnet list --resource-group $RG_Name --query "[?name=='$vnet'] | length(@)") > 0 ]]
        then
           echo "Completed ----"
           az network vnet show --resource-group $RG_Name --name $vnet --query id
        else
           echo "Failed resource creation, aborting ----"
           exit 3
        fi
   fi

   echo "----------------------"
   echo "Creating Subnets for: $vnet from CLI"
   for index in {0..3}
   do
        if [[ $vnet == $Server_vnet ]]; then 
           prefix=${subnets_svnet["$index"]}
        elif [[ $vnet == $Router_vnet ]]; then
           prefix=${subnets_rvnet["$index"]}
        else
           echo "no subnets specified for VNET: $vnet"
           break
        fi
        sub_name="SN$(( $index + 1 ))"
        echo "Check if subnet: $sub_name exists in VNET: $vnet"
        if [[ $(az network vnet subnet list --resource-group $RG_Name --vnet-name $vnet --query "[?name=='$sub_name'] | length(@)") > 0 ]]
        then
           echo "exists"
           az network vnet subnet show --resource-group $RG_Name --vnet-name $vnet --name $sub_name --query id
           echo "address prefix ----"
           az network vnet subnet show --resource-group $RG_Name --vnet-name $vnet --name $sub_name --query addressPrefix
        else
           echo "----------------------"
           echo "Creating Subnet $sub_name for: $vnet from CLI"
           az network vnet subnet create --resource-group $RG_Name --vnet-name $vnet --name $sub_name --address-prefixes $prefix
        fi
   done
done

######################################
#VNET peering uses vnet id
#check vnet id
echo "----------------------"
echo "Runnign Next ... $Student_vnet.id"
stuid=$(az network vnet show --resource-group $RG_Name --name  $Student_vnet --query id --out tsv) 
echo "$stuid"

echo "----------------------"
echo "Runnign Next ... $Server_vnet.id"
srvid=$(az network vnet show --resource-group $RG_Name --name $Server_vnet --query id --out tsv) 
echo "$srvid"

echo "----------------------
echo "Runnign Next ... $Router_vnet.id
rtrid=$(az network vnet show --resource-group $RG_Name --name $Router_vnet --query id --out tsv) 
echo "$rtrid"

if [ -z "$rtrid" -o -z "$srvid" -o -z $stuid ] ; then
        echo "rtrid or srvid or stuid is null "
        echo "program will abort with error 2 in here"
        exit 2
fi

######################################
#VNET Peering Create
echo "----------------------"
echo "Running Next ---------"
echo "Creating Network Peering"
az network vnet peering create --resource-group $RG_Name --name $Peer_RT --vnet-name $Router_vnet --remote-vnet $stuid --allow-vnet-access --allow-forwarded-traffic 
az network vnet peering create --resource-group $RG_Name --name $Peer_TR --vnet-name $Student_vnet --remote-vnet $rtrid --allow-vnet-access --allow-forwarded-traffic 
az network vnet peering create --resource-group $RG_Name --name $Peer_RS --vnet-name $Router_vnet --remote-vnet $srvid --allow-vnet-access --allow-forwarded-traffic 
az network vnet peering create --resource-group $RG_Name --name $Peer_SR --vnet-name $Server_vnet --remote-vnet $rtrid --allow-vnet-access --allow-forwarded-traffic

elif [[ "$command" == "CREATE" ]]; then
######################################
#VNET Creation
echo "----------------------"
echo "Running Next ---------"
echo "az deployment group create --resource-group $RG_Name --template-file ./Router/template.json"
az deployment group create --resource-group $RG_Name --template-file ./Router/template.json 
echo "Completed ------------"

echo "----------------------"
echo "Running Next ---------"
echo "az deployment group create --resource-group $RG_Name --template-file ./Server/template.json"
az deployment group create --resource-group $RG_Name --template-file ./Server/template.json
echo "Completed ------------"

######################################
#VNET peering uses vnet id
#check vnet id
echo "----------------------"
echo "Runnign Next ... $Student_vnet.id"
stuid=$(az network vnet show --resource-group $RG_Name --name  $Student_vnet --query id --out tsv) 
echo "$stuid"

echo "----------------------"
echo "Runnign Next ... $Server_vnet.id"
srvid=$(az network vnet show --resource-group $RG_Name --name $Server_vnet --query id --out tsv) 
echo "$srvid"

echo "----------------------
echo "Runnign Next ... $Router_vnet.id
rtrid=$(az network vnet show --resource-group $RG_Name --name $Router_vnet --query id --out tsv) 
echo "$rtrid"

if [ -z "$rtrid" -o -z "$srvid" -o -z $stuid ] ; then
        echo "rtrid or srvid or stuid is null "
        echo "program will abort with error 2 in here"
        exit 2
fi

######################################
#VNET Peering Create
echo "----------------------"
echo "Running Next ---------"
echo "Creating Network Peering"
az network vnet peering create --resource-group $RG_Name --name $Peer_RT --vnet-name $Router_vnet --remote-vnet $stuid --allow-vnet-access --allow-forwarded-traffic 
az network vnet peering create --resource-group $RG_Name --name $Peer_TR --vnet-name $Student_vnet --remote-vnet $rtrid --allow-vnet-access --allow-forwarded-traffic 
az network vnet peering create --resource-group $RG_Name --name $Peer_RS --vnet-name $Router_vnet --remote-vnet $srvid --allow-vnet-access --allow-forwarded-traffic 
az network vnet peering create --resource-group $RG_Name --name $Peer_SR --vnet-name $Server_vnet --remote-vnet $rtrid --allow-vnet-access --allow-forwarded-traffic


elif [[ "$command" == "DELETE" ]]; then
######################################
#VNET Peering Delete
echo "----------------------"
echo "Running Next ---------"
echo "Deleting Network Peerings"
az network vnet peering delete --resource-group $RG_Name --name $Peer_RT --vnet-name $Router_vnet 
az network vnet peering delete --resource-group $RG_Name --name $Peer_TR --vnet-name $Student_vnet  
az network vnet peering delete --resource-group $RG_Name --name $Peer_RS --vnet-name $Router_vnet  
az network vnet peering delete --resource-group $RG_Name --name $Peer_SR --vnet-name $Server_vnet  

######################################
#VNET Deletion
echo "----------------------"
echo "Running Next ---------"
echo "Deleting VNETs"
az network vnet delete --resource-group $RG_Name --name $Server_vnet  
az network vnet delete --resource-group $RG_Name --name $Router_vnet

else
######################################
echo "----------------------"
echo "No operation done"
echo "usage ./vnet.sh argument"
echo "valid arguments: CREATE, DELETE, SCRIPTED"
fi