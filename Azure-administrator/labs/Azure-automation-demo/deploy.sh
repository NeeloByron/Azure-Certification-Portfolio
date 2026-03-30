

## 🚀 `deploy.sh`

This script creates everything and includes the runbook content inline.

```bash
#!/bin/bash
# Azure Automation Demo - Start/Stop VM with Runbook

set -e

# Variables
resourceGroup="rg-automation-demo"
location="eastus"
automationAccount="myAutomationAccount"
vmName="testvm"
runbookName="Start-Stop-VM"
scheduleName="DailyStop"

echo "=== Azure Automation Demo Setup ==="

# Login check
az account show > /dev/null 2>&1 || az login

# Create resource group
echo "1. Creating resource group..."
az group create --name $resourceGroup --location $location

# Create Automation Account
echo "2. Creating Automation Account..."
az automation account create \
    --resource-group $resourceGroup \
    --name $automationAccount \
    --location $location \
    --sku Basic

# Enable managed identity
echo "3. Enabling managed identity..."
az automation account update \
    --resource-group $resourceGroup \
    --name $automationAccount \
    --assign-identity

# Create test VM
echo "4. Creating test VM..."
az vm create \
    --resource-group $resourceGroup \
    --image Ubuntu2204 \
    --admin-username azureuser \
    --generate-ssh-keys \
    --public-ip-sku Standard

# Wait for VM to be ready
sleep 30

# Assign permissions to the managed identity
echo "5. Assigning Virtual Machine Contributor role to managed identity..."
principalId=$(az automation account show \
    --resource-group $resourceGroup \
    --name $automationAccount \
    --query identity.principalId \
    --output tsv)
vmId=$(az vm show \
    --resource-group $resourceGroup \
    --name $vmName \
    --query id \
    --output tsv)

az role assignment create \
    --assignee $principalId \
    --role "Virtual Machine Contributor" \
    --scope $vmId

# Create and import runbook
cat << 'EOF' > $runbookTemp
    [Parameter(Mandatory=$true)]
    [Parameter(Mandatory=$true)]
    [string]$Action
)

# Connect using the Automation Account's managed identity
Connect-AzAccount -Identity

# Get the VM's resource group (by searching)
$vm = Get-AzVM -Name $VMName
if (-not $vm) {
    Write-Error "VM '$VMName' not found."
    exit 1
}

# Perform the action
switch ($Action) {
    "Start" {
        Write-Output "Starting VM '$VMName'..."
        Start-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name
    }
    "Stop" {
        Write-Output "Stopping VM '$VMName'..."
        Stop-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Force
}
EOF

az automation runbook create \
    --resource-group $resourceGroup \
    --automation-account-name $automationAccount \
    --name $runbookName \
    --type PowerShell \
    --description "Starts or stops a VM"

az automation runbook replace-content \
    --resource-group $resourceGroup \
    --automation-account-name $automationAccount \
    --name $runbookName \
    --content @$runbookTemp

rm $runbookTemp

az automation runbook publish \
    --resource-group $resourceGroup \
    --automation-account-name $automationAccount \
    --name $runbookName

# Create schedule (stop daily at 18:00 UTC)
echo "7. Creating schedule..."
startTime=$(date -u -d "tomorrow 18:00" +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || date -u -v+1d -v18H -v0M -v0S +"%Y-%m-%dT%H:%M:%SZ")
    --resource-group $resourceGroup \
    --automation-account-name $automationAccount \
    --description "Stop VM daily at 18:00 UTC" \
    --frequency Day \
    --interval 1 \
    --start-time $startTime \
    --time-zone UTC

# Link schedule to runbook with parameters
echo "8. Linking schedule to runbook..."
az automation runbook schedule link \
    --resource-group $resourceGroup \
    --automation-account-name $automationAccount \
    --runbook-name $runbookName \
    --schedule-name $scheduleName \
    --parameters "{\"VMName\":\"$vmName\",\"Action\":\"Stop\"}"

echo "=== Setup Complete ==="
echo "Resources created:"
echo "  - Resource group: $resourceGroup"
echo "  - Automation Account: $automationAccount"
echo "  - Runbook: $runbookName"
echo ""
echo "To test the runbook manually, run:"
echo "  az automation runbook start -g $resourceGroup --automation-account-name $automationAccount -n $runbookName --parameters '{\"VMName\":\"$vmName\",\"Action\":\"Start\"}'"
echo "  az group delete --name $resourceGroup --yes --no-wait"
