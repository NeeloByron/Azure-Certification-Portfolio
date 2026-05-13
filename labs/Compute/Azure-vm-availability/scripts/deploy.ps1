$resourceGroup = "rg-vm-availability"

az group create --name $resourceGroup --location $location

az deployment group create `
  --resource-group $resourceGroup `
  --name $deploymentName `
  --template-file main.bicep `
  --parameters .\parameters.json

Write-Host "Deployment complete. VM private IPs:"
az deployment group show --resource-group $resourceGroup --name $deploymentName --query properties.outputs.vmPrivateIPs.value -o tsv
az deployment group show --resource-group $resourceGroup --name $deploymentName --query properties.outputs.vmPublicIPs.value -o tsv
