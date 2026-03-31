#!/bin/bash
# Bicep Learning – Deploy Resource Group and Storage Account

set -e

# Defaults
RESOURCE_GROUP="rg-bicep-demo"
LOCATION="eastus"
STORAGE_NAME="storage${RANDOM}${RANDOM}"

# Parse optional parameters
while [[ $# -gt 0 ]]; do
    case "$1" in
        --resource-group|-g)
            RESOURCE_GROUP="$2"
            shift 2
            ;;
        --location|-l)
            LOCATION="$2"
            shift 2
            ;;
        --storageName|-s)
            STORAGE_NAME="$2"
            shift 2
            ;;
        --sku|-k)
            SKU_NAME="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [--resource-group <name>] [--location <region>] [--storageName <name>] [--sku <sku>]"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

echo "=== Bicep Learning Demo ==="
echo "Resource group: $RESOURCE_GROUP"
echo "Storage account name: $STORAGE_NAME"
echo "SKU: $SKU_NAME"

# Login check
az account show > /dev/null 2>&1 || az login
# Create resource group
az group create --name $RESOURCE_GROUP --location $LOCATION
# Write the Bicep template to a temporary file
cat << EOF > main.bicep
param storageAccountName string = uniqueString(resourceGroup().id)
param location string = resourceGroup().location
param skuName string = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  sku: { name: skuName }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
}

output storageAccountId string = storageAccount.id

# Deploy the Bicep template
az deployment group create \
    --resource-group $RESOURCE_GROUP \
    --parameters storageAccountName=$STORAGE_NAME skuName=$SKU_NAME
# Get outputs
STORAGE_ID=$(az deployment group show -g $RESOURCE_GROUP --query properties.outputs.storageAccountId.value -o tsv)

echo "=== Deployment Complete ==="
echo "Storage account name: $STORAGE_NAME_OUT"
echo "Storage account ID: $STORAGE_ID"
echo ""
echo "To clean up, run:"
echo "  az group delete --name $RESOURCE_GROUP --yes --no-wait"
