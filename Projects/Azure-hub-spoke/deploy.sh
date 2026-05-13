#!/bin/bash
RESOURCE_GROUP="rg-hub-spoke"
echo "Creating resource group $RESOURCE_GROUP in $LOCATION..."
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Deploying Bicep template..."
az deployment group create \
    --resource-group $RESOURCE_GROUP \
    --template-file main.bicep \
    --parameters location=$LOCATION

echo "Deployment complete."
echo "Firewall public IP:"
az network public-ip show -g $RESOURCE_GROUP -n fw-pip --query ipAddress -o tsv
echo "To test:"
echo "1. Deploy a test VM in one of the spoke subnets."
echo "2. Connect to it (e.g., via Bastion or a jumpbox)."
echo "3. Run: curl -I https://example.com   (should succeed)"
echo "Clean up when done: az group delete -n $RESOURCE_GROUP --yes --no-wait"
