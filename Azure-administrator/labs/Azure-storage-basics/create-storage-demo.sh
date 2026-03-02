#!/bin/bash
# Creates a storage account, a container, and uploads a blob.

# Variables – change these as needed
RESOURCE_GROUP="rg-storage-demo"
LOCATION="eastus"
STORAGE_ACCOUNT="mystorageaccount$RANDOM"   # Must be globally unique
CONTAINER_NAME="mycontainer"
BLOB_FILE="sample.txt"

# Create a sample file to upload
echo "Hello, Azure Storage!" > $BLOB_FILE

# Login required (already logged in assumed)

# Create resource group if it doesn't exist
az group show --name $RESOURCE_GROUP &>/dev/null || \
  az group create --name $RESOURCE_GROUP --location $LOCATION

# Create storage account
echo "Creating storage account: $STORAGE_ACCOUNT"
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS

# Get connection string
CONNECTION_STRING=$(az storage account show-connection-string \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --query connectionString -o tsv)

# Create container
echo "Creating container: $CONTAINER_NAME"
az storage container create \
  --name $CONTAINER_NAME \
  --connection-string "$CONNECTION_STRING"

# Upload blob
echo "Uploading $BLOB_FILE to container..."
az storage blob upload \
  --container-name $CONTAINER_NAME \
  --file $BLOB_FILE \
  --name $BLOB_FILE \
  --connection-string "$CONNECTION_STRING"

# List blobs to verify
echo "Blobs in container:"
az storage blob list \
  --container-name $CONTAINER_NAME \
  --output table \
  --connection-string "$CONNECTION_STRING"

echo "✅ Demo completed."
