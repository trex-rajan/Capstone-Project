# Azure Scripting

**Quick Start with bash**
```bash
az connect list
az group create --location westus --name MyRG
az group delete -n MyRG

az account set --subscription 'my-subscription-name'
```
**Working with resource groups**
```
az group list --output table
```

---
Useful Links:
- [Quickstart for Bash in Azure Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/quickstart)
- [Commands Reference](https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest)
- [Azure CLI samples for virtual network](https://docs.microsoft.com/en-us/azure/virtual-network/cli-samples?toc=%2Fcli%2Fazure%2Ftoc.json&bc=%2Fcli%2Fazure%2Fbreadcrumb%2Ftoc.json&view=azure-cli-latest)
- [Azure CI - Az Accounts](https://docs.microsoft.com/en-us/cli/azure/account?view=azure-cli-latest#az-account-set)
- [How to use Azure CLI effectively](https://docs.microsoft.com/en-us/cli/azure/use-cli-effectively)
- [How to query Azure CLI command output using a JMESPath query](https://docs.microsoft.com/en-us/cli/azure/query-azure-cli?tabs=concepts%2Cbash)