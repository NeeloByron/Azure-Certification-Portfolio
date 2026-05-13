#!/bin/bash

# Variables – update these to match your environment
RESOURCE_GROUP="rg-sas-lab"
STORAGE_ACCOUNT="saslab32024"          # replace with your actual storage account
CONTAINER_NAME="sas-test-container"
BLOB_NAME="sample.txt"

# Get account key
ACCOUNT_KEY=$(az storage account keys list \
    --account-name $STORAGE_ACCOUNT \
    --resource-group $RESOURCE_GROUP \
    --query "[0].value" -o tsv)

# Generate container SAS token (valid 1 hour)
SAS_TOKEN=$(az storage container generate-sas \
    --account-name $STORAGE_ACCOUNT \
    --name $CONTAINER_NAME \
    --permissions rwdl \
    --expiry $(date -u -d "1 hour" '+%Y-%m-%dT%H:%MZ') \
    --account-key "$ACCOUNT_KEY" \
    --output tsv)

echo "Container SAS Token: $SAS_TOKEN"

# Generate blob SAS token (read-only, 10 minutes)
BLOB_SAS_TOKEN=$(az storage blob generate-sas \
    --account-name $STORAGE_ACCOUNT \
    --container-name $CONTAINER_NAME \
    --name $BLOB_NAME \
    --permissions r \
    --expiry $(date -u -d "10 minutes" '+%Y-%m-%dT%H:%MZ') \
    --account-key "$ACCOUNT_KEY" \
    --output tsv)

echo "Blob SAS Token: $BLOB_SAS_TOKEN"

