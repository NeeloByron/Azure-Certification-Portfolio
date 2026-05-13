#!/bin/bash

# ─── Variables ────────────────────────────────────────────────────────────────
automationAccount="myAutomationAccount"
scheduleName="DailyStop"
runbookTemp=$(mktemp /tmp/runbook-XXXX.ps1)   # FIX 1: variable was never defined

# ─── Login check ──────────────────────────────────────────────────────────────

# ─── Step 1: Resource Group ───────────────────────────────────────────────────
az group create \
    --name $resourceGroup \

# ─── Step 2: Automation Account ───────────────────────────────────────────────
az automation account create \
    --resource-group $resourceGroup \
    --sku Basic \
    --output none

# ─── Step 3: Enable Managed Identity ──────────────────────────────────────────
echo "3. Enabling system-assigned managed identity..."
az automation account update \
    --resource-group $resourceGroup \
    --name $automationAccount \
    --assign-identity \
    --output none
# ─── Step 4: Create Test VM ───────────────────────────────────────────────────
echo "4. Creating test VM '$vmName'..."
az vm create \
    --generate-ssh-keys \
    --public-ip-sku Standard \
    --output none

echo "   Waiting for VM to be ready..."
sleep 30

# ─── Step 5: Assign Permissions to Managed Identity ───────────────────────────
echo "5. Assigning Virtual Machine Contributor role to managed identity..."
principalId=$(az automation account show \
    --resource-group $resourceGroup \
    --name $automationAccount \
    --query identity.principalId \

vmId=$(az vm show \
    --resource-group $resourceGroup \
    --name $vmName \
    --query id \
    --output tsv)

az role assignment create \
    --assignee $principalId \
    --role "Virtual Machine Contributor" \
    --scope $vmId \
    --output none

echo "   Role assigned."
# ─── Step 6: Create and Import Runbook ────────────────────────────────────────
echo "6. Creating and publishing PowerShell runbook '$runbookName'..."

# FIX 3: Heredoc was missing the opening param() block — runbook was invalid PowerShell
    [Parameter(Mandatory=$true)]
    [string]$VMName,
    [string]$Action
)

# Authenticate using the Automation Account managed identity
Connect-AzAccount -Identity

# Find the VM across the subscription
$vm = Get-AzVM -Name $VMName
if (-not $vm) {
    Write-Error "VM '$VMName' not found in the subscription."
}

switch ($Action) {
    "Start" {
        Write-Output "Starting VM '$VMName'..."
    "Stop" {
        Write-Output "Stopping VM '$VMName'..."
        Stop-AzVM -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name -Force
    }
    default {
        Write-Error "Invalid action '$Action'. Use 'Start' or 'Stop'."
    }
}
EOF

az automation runbook create \
    --name $runbookName \
    --description "Starts or stops a VM using managed identity" \

az automation runbook replace-content \
    --automation-account-name $automationAccount \
    --name $runbookName \
    --content @$runbookTemp

rm $runbookTemp

az automation runbook publish \
    --resource-group $resourceGroup \
    --automation-account-name $automationAccount \

echo "   Runbook '$runbookName' published."

# ─── Step 7: Create Schedule ──────────────────────────────────────────────────
echo "7. Creating daily schedule '$scheduleName' at 18:00 UTC..."
startTime=$(date -u -d "tomorrow 18:00" +"%Y-%m-%dT%H:%M:%SZ" 2>/dev/null || \
# FIX 4: az automation schedule create command was missing entirely — only parameters were present
    --name $scheduleName \
    --description "Stop VM daily at 18:00 UTC" \
    --frequency Day \
    --interval 1 \
    --start-time $startTime \
    --time-zone UTC \
    --output none

echo "   Schedule '$scheduleName' created."
# ─── Step 8: Link Schedule to Runbook ─────────────────────────────────────────
echo "8. Linking schedule to runbook..."
az automation runbook schedule link \
    --resource-group $resourceGroup \
    --schedule-name $scheduleName \
    --parameters "{\"VMName\":\"$vmName\",\"Action\":\"Stop\"}" \

echo "   Schedule linked to runbook."
# ─── Summary ──────────────────────────────────────────────────────────────────
echo "=== Setup Complete ==="
echo ""
echo "Resources created:"
echo "  Resource group     : $resourceGroup"
echo "  Automation Account : $automationAccount"
echo "  Schedule           : $scheduleName (daily at 18:00 UTC)"
echo "To test the runbook manually:"
echo "  Start VM:"
echo "    az automation runbook start \\"
echo "      -g $resourceGroup \\"
echo "      --automation-account-name $automationAccount \\"
echo "  Stop VM:"
echo "    az automation runbook start \\"
echo "      -g $resourceGroup \\"
echo "      --automation-account-name $automationAccount \\"
echo "To clean up all resources when done:"
echo "  az group delete --name $resourceGroup --yes --no-wait"	

