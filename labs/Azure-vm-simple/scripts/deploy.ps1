$resourceGroup = "rg-vm-simple"

az deployment group create `
  --resource-group $resourceGroup `
  --name $deploymentName `
  --template-file main.bicep `
  --parameters .\parameters.json

Write-Host "Deployment complete. VM public IP:"
az deployment group show --resource-group $resourceGroup --name $deploymentName --query properties.outputs.vmPublicIp.value -o tsv
