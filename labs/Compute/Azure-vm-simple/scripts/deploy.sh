#!/bin/bash
az group create --name $RESOURCE_GROUP --location $LOCATION
  --resource-group $RESOURCE_GROUP \
  --name $DEPLOYMENT_NAME \
  --template-file main.bicep \
  --parameters @parameters.json

echo "Deployment complete. VM public IP:"
az deployment group show --resource-group $RESOURCE_GROUP --name $DEPLOYMENT_NAME --query properties.outputs.vmPublicIp.value -o tsv
