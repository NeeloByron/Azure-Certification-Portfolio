#!/bin/bash
# Azure Monitor Labs - Configure Diagnostic Settings and Create a Log Alert

set -e

# Variables
resourceGroup="rg-monitor-labs"
location="eastus"
workspaceName="loganalytics$RANDOM"
vmName="testvm"
actionGroupName="email-action-group"
alertName="vm-start-alert"

echo "=== Azure Monitor Labs - Log Alert Demo ==="
# Check login
az account show > /dev/null 2>&1 || az login

# Prompt for email
read -p "Enter your email address for alerts: " recipientEmail
if [ -z "$recipientEmail" ]; then
    echo "Email address required. Exiting."
    exit 1
fi

# 1. Create resource group
echo "1. Creating resource group..."

# 2. Create Log Analytics workspace
echo "2. Creating Log Analytics workspace..."
    --resource-group $resourceGroup \
    --workspace-name $workspaceName \
    --location $location

# 3. Enable diagnostic settings for Activity Log
echo "3. Enabling diagnostic settings for subscription Activity Logs..."
subscriptionId=$(az account show --query id -o tsv)
workspaceId=$(az monitor log-analytics workspace show \
    --resource-group $resourceGroup \
    --workspace-name $workspaceName \
    --query id -o tsv)

az monitor diagnostic-settings create \
    --name "send-activity-logs-to-workspace" \
    --logs '[{"category": "Administrative", "enabled": true}]' \
    --workspace $workspaceId

# 4. Create a test VM
echo "4. Creating a test VM (this will take a few minutes)..."
az vm create \
    --resource-group $resourceGroup \
    --name $vmName \
    --image Ubuntu2204 \
    --admin-username azureuser \
    --generate-ssh-keys

# 5. Create an action group
echo "5. Creating action group for email notifications..."
actionGroupId=$(az monitor action-group create \
    --resource-group $resourceGroup \
    --name $actionGroupName \
    --short-name "email" \
    --action email "email-action" $recipientEmail \
    --query id -o tsv)

# 6. Create a log alert rule
echo "6. Creating log alert rule that triggers when the VM is started..."
vmId=$(az vm show -g $resourceGroup -n $vmName --query id -o tsv)
# KQL query to detect VM start events
query="AzureActivity | where ResourceId == \"$vmId\" and OperationName == \"Microsoft.Compute/virtualMachines/start/action\""
# Create the alert
az monitor scheduled-query create \
    --resource-group $resourceGroup \
    --name $alertName \
    --scopes "/subscriptions/$subscriptionId" \
    --condition "count '$query' > 0" \
    --action-groups $actionGroupId \
    --description "Alert when the test VM is started" \
    --severity 2 \
    --evaluation-frequency 5m \
    --window-size 5m

# Get the workspace ID (for reference)
workspaceResourceId=$(az monitor log-analytics workspace show \
    --query id -o tsv)

echo "=== Deployment Complete ==="
echo "Log Analytics Workspace: $workspaceName"
echo "Test VM: $vmName"
echo "Alert: $alertName (triggers when VM is started)"
echo "To test the alert, start the VM using:"
echo "  az vm start --resource-group $resourceGroup --name $vmName"
echo ""
echo "You should receive an email at $recipientEmail within a few minutes."
echo ""
echo "To clean up:"
echo "  az group delete --name $resourceGroup --yes --no-wait"
