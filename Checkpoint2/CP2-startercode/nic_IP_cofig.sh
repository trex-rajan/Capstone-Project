# Assigning Sattic IP addresses

echo "Load variables from config.sh"
source ./config.sh

######################################
# Configure IP forwarding in Router
echo "----------------------"
echo "Running Next ---------"
echo "Routers configure -----"
echo
echo "forwarding enable ... "
az network nic update --name  $NIC_LR  --resource-group $RG_Name --ip-forwarding true 2>/dev/null
