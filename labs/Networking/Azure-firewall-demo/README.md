#Deploy Azure Firewall with a simple rule

# Azure Firewall Demo – Deploy Azure Firewall with a Simple Rule

## Overview

This lab demonstrates how to deploy Azure Firewall in a hub‑spoke network topology and configure a basic application rule to control outbound internet access. You will create a test virtual machine that has all its internet traffic routed through the firewall, and then verify that only traffic to a specific allowed website (`example.com`) passes, while other traffic is blocked.

This is a fundamental skill for implementing centralised security policies in Azure.

## What You'll Learn

- How to create a hub VNet with dedicated subnets for Azure Firewall and a workload.
- How to deploy and configure Azure Firewall with a public IP.
- How to create a route table to force traffic from the workload subnet through the firewall.
- How to configure an application rule collection to allow specific outbound web traffic.
- How to test the firewall rules from a test VM.

## Prerequisites

- An active **Azure subscription** (free trial works).
- **Azure CLI** installed and logged in (`az login`).
- Basic familiarity with the command line.

## Architecture

[Internet]
^
| (Controlled outbound traffic)
|
+---------------------------------------------------+
| Hub VNet (10.0.0.0/16) |
| +-------------------+ +-----------------------+ |
| | AzureFirewallSubnet| | Azure Firewall | |
| | (10.0.1.0/24) | | - Public IP | |
| | | | - Private IP | |
| +-------------------+ +-----------------------+ |
| | (Forces all traffic) |
| v |
| +-----------------------+ |
| | Route Table | |
| | - Default route to | |
| | firewall private IP | |
| +-----------------------+ |
| | |
| v |
| +-----------------------+ +-------------------+ |
| | Workload Subnet | | Test VM | |
| | (10.0.2.0/24) | | (no public IP) | |
| +-----------------------+ +-------------------+ |
+---------------------------------------------------+


## Step‑by‑Step Instructions (Azure CLI)

### 1. Set Environment Variables

```bash
# Resource Group
resourceGroup="rg-firewall-demo"
location="eastus"

# Virtual Network (Hub)
vnetName="hub-vnet"
vnetPrefix="10.0.0.0/16"

# Subnets
firewallSubnetName="AzureFirewallSubnet"   # Must be exactly this name
firewallSubnetPrefix="10.0.1.0/24"
workloadSubnetName="workload"
workloadSubnetPrefix="10.0.2.0/24"

# Firewall
firewallName="myFirewall"
firewallPublicIpName="fw-pip"

# Route Table
routeTableName="fw-route-table"
routeName="DefaultRoute"

# Test VM
vmName="testVM"
vmAdminUser="azureuser"


---

## 🔧 Optional Script: `deploy.sh`

You can combine all the commands into a single script. Below is a sample `deploy.sh` (make it executable with `chmod +x deploy.sh`). It includes error handling and waits for the firewall to be ready.

```bash
#!/bin/bash
# Azure Firewall Demo - Full Deployment Script

set -e  # Exit on error

# Variables
resourceGroup="rg-firewall-demo"
location="eastus"
vnetName="hub-vnet"
vnetPrefix="10.0.0.0/16"
firewallSubnetName="AzureFirewallSubnet"
firewallSubnetPrefix="10.0.1.0/24"
workloadSubnetName="workload"
workloadSubnetPrefix="10.0.2.0/24"
firewallName="myFirewall"
firewallPublicIpName="fw-pip"
routeTableName="fw-route-table"
routeName="DefaultRoute"
vmName="testVM"
vmAdminUser="azureuser"

# Create RG
echo "Creating resource group..."
az group create --name $resourceGroup --location $location

# Create VNet and subnets
echo "Creating VNet and subnets..."
az network vnet create --resource-group $resourceGroup --name $vnetName --address-prefix $vnetPrefix
az network vnet subnet create --resource-group $resourceGroup --vnet-name $vnetName --name $firewallSubnetName --address-prefix $firewallSubnetPrefix
az network vnet subnet create --resource-group $resourceGroup --vnet-name $vnetName --name $workloadSubnetName --address-prefix $workloadSubnetPrefix

# Create public IP for firewall
echo "Creating public IP for firewall..."
az network public-ip create --resource-group $resourceGroup --name $firewallPublicIpName --sku Standard --allocation-method Static

# Deploy firewall
echo "Deploying firewall (this takes 5-10 minutes)..."
az network firewall create \
  --resource-group $resourceGroup \
  --name $firewallName \
  --location $location \
  --vnet-name $vnetName \
  --public-ip-address $firewallPublicIpName

# Wait for firewall to be ready
echo "Waiting for firewall to provision..."
while [ "$(az network firewall show -g $resourceGroup -n $firewallName --query provisioningState -o tsv)" != "Succeeded" ]; do
  echo "Still provisioning..."
  sleep 30
done

# Get firewall private IP
firewallPrivateIp=$(az network firewall show -g $resourceGroup -n $firewallName --query "ipConfigurations[0].privateIPAddress" -o tsv)
echo "Firewall private IP: $firewallPrivateIp"

# Create route table and route
echo "Creating route table..."
az network route-table create --resource-group $resourceGroup --name $routeTableName
az network route-table route create \
  --resource-group $resourceGroup \
  --route-table-name $routeTableName \
  --name $routeName \
  --address-prefix 0.0.0.0/0 \
  --next-hop-type VirtualAppliance \
  --next-hop-ip-address $firewallPrivateIp

# Associate route table with workload subnet
az network vnet subnet update \
  --resource-group $resourceGroup \
  --vnet-name $vnetName \
  --name $workloadSubnetName \
  --route-table $routeTableName

# Create test VM (no public IP)
echo "Creating test VM (no public IP)..."
az vm create \
  --resource-group $resourceGroup \
  --name $vmName \
  --image Ubuntu2204 \
  --vnet-name $vnetName \
  --subnet $workloadSubnetName \
  --admin-username $vmAdminUser \
  --generate-ssh-keys \
  --public-ip-address ""

# Add firewall rule
echo "Adding firewall rule to allow example.com..."
az network firewall application-rule create \
  --resource-group $resourceGroup \
  --firewall-name $firewallName \
  --collection-name "AllowExample" \
  --priority 100 \
  --action Allow \
  --name "AllowExampleCom" \
  --protocols "http=80" "https=443" \
  --source-addresses "*" \
  --target-fqdns "example.com"

echo "Deployment complete. Connect to the VM via serial console in the Azure portal to test."
