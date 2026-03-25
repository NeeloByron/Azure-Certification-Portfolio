#!/bin/bash
# Azure Cost Tags - Demo Script

set -e

# Variables
resourceGroup="rg-cost-demo"
location="eastus"
vmName="costvm"
budgetName="demo-budget"
budgetAmount=10
budgetNotificationThreshold=100  # percentage

# Get subscription ID
subscriptionId=$(az account show --query id -o tsv)

# Prompt for recipient email
read -p "Enter the email address for budget alerts: " recipientEmail

echo "=== Azure Cost Tags Demo ==="
echo "Resource group: $resourceGroup"
echo "Location: $location"
echo "Budget: $budgetName ($budgetAmount USD / month)"
echo "Alerts will be sent to: $recipientEmail"
echo ""

# Create resource group with tags
echo "1. Creating resource group with tags..."
az group create \
    --name $resourceGroup \
    --location $location \
    --tags Environment=Test Project=CostDemo

# Create VM with tags
echo "2. Creating a virtual machine with tags..."
az vm create \
    --resource-group $resourceGroup \
    --name $vmName \
    --image Ubuntu2204 \
    --admin-username azureuser \
    --generate-ssh-keys \
    --tags Environment=Test Project=CostDemo

# Add a tag to the resource group (example of updating tags)
echo "3. Adding another tag to the resource group..."
az group update \
    --name $resourceGroup \
    --set tags.Owner=Finance

# Create a budget alert
echo "4. Creating budget alert ($budgetAmount USD per month)..."
# Build the notifications JSON string
notifications="{\"NotificationName\":{\"enabled\":true,\"operator\":\"GreaterThan\",\"threshold\":$budgetNotificationThreshold,\"contactEmails\":[\"$recipientEmail\"]}}"

az consumption budget create \
    --budget-name $budgetName \
    --subscription $subscriptionId \
    --amount $budgetAmount \
    --time-grain Monthly \
    --start-date $(date +%Y-%m-01) \
    --end-date $(date -d "+6 months" +%Y-%m-01) \
    --notifications "$notifications"

echo "=== Setup Complete ==="
echo ""
echo "Resources created:"
echo "  - Resource group: $resourceGroup (tags: Environment=Test, Project=CostDemo, Owner=Finance)"
echo "  - VM: $vmName (tags: Environment=Test, Project=CostDemo)"
echo "  - Budget: $budgetName (threshold: $budgetAmount USD, alert at $budgetNotificationThreshold%)"
echo ""
echo "You can view the budget in the Azure portal: Cost Management + Billing → your subscription → Budgets"
echo ""
echo "To delete all resources and the budget, run:"
echo "  az group delete --name $resourceGroup --yes --no-wait"
echo "  az consumption budget delete --budget-name $budgetName --subscription $subscriptionId"
