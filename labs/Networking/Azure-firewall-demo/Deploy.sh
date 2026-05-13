#!/bin/bash

set -e  # Exit immediately if any command fails
echo "=== Azure Firewall Demo Lab ==="
# --- Variables (you can modify these) ---
vnetPrefix="10.0.0.0/16"
firewallSubnetName="AzureFirewallSubnet"
workloadSubnetName="workload"
firewallPublicIpName="fw-pip"
routeTableName="fw-route-table"
vmName="testVM"
vmAdminUser="azureuser"
# --- Create Resource Group ---
echo "1. Creating resource group $resourceGroup in $location..."
az group create --name $resourceGroup --location $location
# --- Create VNet and Subnets ---
az network vnet create \
  --name $vnetName \
  --address-prefix $vnetPrefix

az network vnet subnet create \
  --vnet-name $vnetName \
  --name $firewallSubnetName \
  --address-prefix $firewallSubnetPrefix

az network vnet subnet create \
  --resource-group $resourceGroup \
  --name $workloadSubnetName \
  --address-prefix $workloadSubnetPrefix
# --- Create Public IP for Firewall ---
echo "3. Creating public IP for firewall..."
  --sku Standard \
  --allocation-method Static

# --- Deploy Firewall (this takes 5-10 minutes) ---
  --name $firewallName \
  --location $location \
  --vnet-name $vnetName \
  --public-ip-address $firewallPublicIpName
# --- Wait for Firewall to be Provisioned ---
echo "5. Waiting for firewall to be provisioned..."
while true; do
  state=$(az network firewall show --resource-group $resourceGroup --name $firewallName --query provisioningState -o tsv)
  else
    echo "  Still provisioning (current state: $state)... waiting 30 seconds."
  fi
done

# --- Get Firewall Private IP ---
  --query "ipConfigurations[0].privateIPAddress" \
echo "Firewall private IP: $firewallPrivateIp"
# --- Create Route Table and Default Route ---
echo "6. Creating route table to force traffic through firewall..."
  --name $routeTableName

az network route-table route create \
  --address-prefix 0.0.0.0/0 \
  --next-hop-type VirtualAppliance \
  --next-hop-ip-address $firewallPrivateIp
echo "7. Associating route table with workload subnet..."
az network vnet subnet update \
  --resource-group $resourceGroup \
  --vnet-name $vnetName \
  --name $workloadSubnetName \
  --route-table $routeTableName

# --- Create Test VM (No Public IP) ---
  --resource-group $resourceGroup \
  --name $vmName \
  --image Ubuntu2204 \
  --vnet-name $vnetName \
  --subnet $workloadSubnetName \
  --admin-username $vmAdminUser \

# --- Add Firewall Rule to Allow example.com ---
  --resource-group $resourceGroup \
  --firewall-name $firewallName \
  --collection-name "AllowExample" \
  --priority 100 \
  --action Allow \
  --source-addresses "*" \

echo "=== Deployment complete! ==="
echo "  1. Go to Azure portal -> your VM -> Serial console (under Help)."
