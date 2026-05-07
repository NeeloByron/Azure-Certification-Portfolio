#!/bin/bash
set -e  # Exit immediately if any command fails

# ─── Variables ────────────────────────────────────────────────────────────────
location="eastus"
vmName="testvm"
vaultName="myRecoveryVault"
adminUser="azureuser"

echo "=== Azure Backup Demo Setup ==="

# ─── Login check ──────────────────────────────────────────────────────────────
# ─── Step 1: Resource Group ───────────────────────────────────────────────────
az group create \
    --location $location \
    --output none

# ─── Step 2: Linux VM ─────────────────────────────────────────────────────────
echo "2. Creating Linux VM '$vmName'..."
az vm create \
    --resource-group $resourceGroup \
    --image Ubuntu2204 \
    --admin-username $adminUser \
    --public-ip-sku Standard \
    --output none

echo "   VM '$vmName' created."
# ─── Step 3: Recovery Services Vault ──────────────────────────────────────────
echo "3. Creating Recovery Services vault '$vaultName'..."
az backup vault create \
    --name $vaultName \
    --location $location \
    --output none

echo "   Vault '$vaultName' created."

# ─── Step 4: Enable Backup on VM ──────────────────────────────────────────────
echo "4. Enabling backup on VM '$vmName' using DefaultPolicy..."
    --resource-group $resourceGroup \
    --vault-name $vaultName \
    --vm $vmName \
    --policy-name DefaultPolicy \
    --output none

echo "   Backup protection enabled."

# ─── Step 5: On-Demand Backup ─────────────────────────────────────────────────
echo "5. Triggering on-demand backup (retain until $retainUntil)..."
jobId=$(az backup protection backup-now \
    --resource-group $resourceGroup \
    --container-name $vmName \
    --item-name $vmName \
    --retain-until $retainUntil \
    --backup-management-type AzureIaasVM \

echo "   Backup job started: $jobId"

# ─── Poll job status ──────────────────────────────────────────────────────────
    status=$(az backup job show \
        --vault-name $vaultName \
        --name $jobId \
        --query properties.status -o tsv)

    if [ "$status" == "Completed" ]; then
        echo "   ✅ Backup completed successfully."
        break
    elif [ "$status" == "Failed" ]; then
        echo "   ❌ Backup failed. Check the Azure portal for details."
    else
        echo "   Status: $status — waiting 30 seconds..."
done

# ─── Step 6: List Recovery Points ─────────────────────────────────────────────
echo ""
echo "6. Listing latest recovery point..."
rpName=$(az backup recoverypoint list \
    --vault-name $vaultName \
    --container-name $vmName \
    --backup-management-type AzureIaasVM \
    --query "[0].name" -o tsv)

echo "   Latest recovery point: $rpName"

# ─── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo "Resources created:"
echo "  Resource group : $resourceGroup"
echo "  VM             : $vmName"
echo "  Vault          : $vaultName"
echo "  Recovery point : $rpName"
echo ""
echo "To perform a file-level restore:"
echo "  1. Go to Azure Portal → Recovery Services Vault → Backup Items"
echo "  2. Select '$vmName' → File Recovery"
echo "  3. Choose a recovery point and download the recovery script"
echo "  4. Run the script on the VM to mount the recovery disk"
echo "  5. Copy your files from the mounted volume"
echo "To clean up all resources when done:"






