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
az deployment group create     --resource-group rg-bicep-demo     --parameters storageAccountName=storage2451623209 skuName=
# Get outputs
STORAGE_ID=

echo "=== Deployment Complete ==="
echo "Storage account name: "
echo "Storage account ID: "
echo ""
echo "To clean up, run:"
echo "  az group delete --name rg-bicep-demo --yes --no-wait"
