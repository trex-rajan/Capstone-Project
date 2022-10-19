# Creating Checkpoint1 Resources with bash

# echo "Load variables from config.sh"
source ./config.sh

######################################
#Dev Test Lab deployment 
az deployment group create --resource-group $RG_Name --template-file ./DevTestLab/template.json

######################################
#Dev Test Lab Deletion
# az lab delete --resource-group $RG_Name --name $DevTest_Lab