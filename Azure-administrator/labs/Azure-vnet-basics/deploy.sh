#!/bin/bash
location="eastus"
vnetName="app-vnet"
vnetAddressPrefix="10.0.0.0/16"
frontendSubnetName="frontend"
frontendSubnetPrefix="10.0.1.0/24"
backendSubnetName="backend"
backendSubnetPrefix="10.0.2.0/24"
nsgName="backend-nsg"

az group create --name $resourceGroup --location $location
# ... (add all the other commands from your lab)

