#!/bin/bash
location="eastus"
vnetName="app-vnet"
vnetAddressPrefix="10.0.0.0/16"
frontendSubnetName="frontend"
frontendSubnetPrefix="10.0.1.0/24"
backendSubnetName="backend"
backendSubnetPrefix="10.0.2.0/24"
nsgName="backend-nsg"

# Create VNet and Frontend Subnet
    --resource-group $resourceGroup \
    --name $vnetName \
    --address-prefix $vnetAddressPrefix \
    --subnet-name $frontendSubnetName \
    --subnet-prefix $frontendSubnetPrefix

# Create the Backend Subnet
az network vnet subnet create \
    --resource-group $resourceGroup \
    --vnet-name $vnetName \
    --name $backendSubnetName \
    --address-prefix $backendSubnetPrefix

#Create a Network Security Group (NSG)
az network nsg create \
    --name $nsgName

#Associate the NSG with the backend Subnet
az network vnet subnet update \
--resource-group $resourceGroup \
--vnet-name $vnetName \
--name $backendSubnetName \
--network-security-group $nsgName

#Add an inbound Security Rule to Allow SSH from the Frontend
az network nsg rule create \
--resource-group $resourceGroup \
--nsg-name $nsgName \
--name AllowSSHFromFrontend \
--priority 100 \
--source-address-prefixes $frontendSubnetPrefix \
--source-port-ranges '*' \
--destination-address-prefixes '*' \
--destination-port-ranges 22 \
--protocl Tcp \
--access Allow \
--description "Allow SSH from Frontend Subnet only"

#Latest Ubuntu Server 2204 image URN
az vm image list --offer Ubuntu2204 --all --output table

# Create the VM without a public IP (we will use a public IP for this lab for easy access, but in production, consider using Azure Bastion)
    --name FrontendVM \
    --vnet-name $vnetName \
    --subnet $frontendSubnetName \
    --image <Your-Ubuntu-Image-URN> \
    --admin-username azureuser \
    --generate-ssh-keys

az vm create \
    --name BackendVM \
    --vnet-name $vnetName \
    --subnet $backendSubnetName \
    --image <Your-Ubuntu-Image-URN> \
    --admin-username azureuser \
    --generate-ssh-keys

# Get FrontendVM Public IP

# Get BackendVM Public IP
az vm show -d -g $resourceGroup -n BackendVM --query publicIps -o tsv
+Azure Network Peerping lab(to-do)
