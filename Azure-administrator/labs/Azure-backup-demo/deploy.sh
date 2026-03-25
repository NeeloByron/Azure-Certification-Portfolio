#!/bin/bash
# Azure Backup Demo - Automated Setup


# Variables
resourceGroup="rg-backup-demo"
location="eastus"
vmName="testvm"
vaultName="myRecoveryVault"
adminUser="azureuser"
retainUntil=$(date -d "+30 days" +%Y-%m-%d)  # Retention date for on-demand backup
echo "=== Azure Backup Demo Setup ==="

# Login check
az account show > /dev/null 2>&1 || az login

echo "1. Creating resource group $resourceGroup in $location..."
az group create --name $resourceGroup --location $location
echo "2. Creating a Linux VM ($vmName)..."
az vm create \
    --resource-group $resourceGroup \
    --name $vmName \
    --image Ubuntu2204 \
    --admin-username $adminUser \
    --generate-ssh-keys \
    --public-ip-sku Standard

echo "3. Creating Recovery Services vault $vaultName..."
    --resource-group $resourceGroup \
    --name $vaultName \
    --location $location

echo "4. Enabling backup on VM using default policy..."
    --resource-group $resourceGroup \
    --vault-name $vaultName \
    --vm $vmName \
    --policy-name DefaultPolicy

echo "5. Taking an on-demand backup (retain until $retainUntil)..."
    --resource-group $resourceGroup \
    --vault-name $vaultName \
    --container-name $vmName \
    --item-name $vmName \
    --retain-until $retainUntil \
    --query name -o tsv)

echo "   Backup job started: $jobId"
# Wait for backup job to succeed
    status=$(az backup job show \
        --resource-group $resourceGroup \
        --vault-name $vaultName \
        --name $jobId \
        --query status -o tsv)
    if [ "$status" == "Completed" ]; then
        echo "   Backup completed."
    elif [ "$status" == "Failed" ]; then
        echo "   Backup failed. Check Azure portal for details."
        exit 1
    else
        echo "   Backup status: $status. Waiting 30 seconds..."
    fi
done

echo "6. Listing recovery points (latest):"
rpName=$(az backup recoverypoint list \
    --resource-group $resourceGroup \
    --container-name $vmName \
    --item-name $vmName \
    --query "[0].name" -o tsv)

echo "   Latest recovery point name: $rpName"

echo ""
echo "=== Setup Complete ==="
echo "Resources created:"
echo "  - Resource group: $resourceGroup"
echo "  - VM: $vmName"
echo "  - Recovery Services vault: $vaultName"
echo ""
echo "To perform a file-level restore:"
echo "  1. Create a storage account (for staging the recovery disk):"
echo "  2. Trigger file restore:"
echo "       az backup restore restore-files \\"
echo "           -g $resourceGroup --vault-name $vaultName \\"
echo "           --target-vm-name $vmName \\"
echo ""
echo "  3. Follow instructions from the Azure portal to mount the recovery disk and copy files."
echo "To delete all resources when done:"
echo "   az group delete --name $resourceGroup --yes --no-wait"




















