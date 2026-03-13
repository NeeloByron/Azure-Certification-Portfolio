#!/bin/bash
LOCATION="eastus"
DEPLOYMENT_NAME="vm-avail-deploy"

az group create --name $RESOURCE_GROUP --location $LOCATION
az deployment group create \
  --resource-group $RESOURCE_GROUP \
  --name $DEPLOYMENT_NAME \
  --template-file main.bicep \

echo "Deployment complete. VM private IPs:"
echo "VM public IPs (if enabled):"
az deployment group show --resource-group $RESOURCE_GROUP --name $DEPLOYMENT_NAME --query properties.outputs.vmPublicIPs.value -o tsv
