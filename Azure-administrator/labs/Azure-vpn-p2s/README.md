#Set up Point to Site VPN

# Azure Point-to-Site VPN Lab

## Overview
This lab demonstrates how to configure a Point-to-Site (P2S) VPN connection to securely connect an individual client computer to an Azure virtual network. You'll create a VPN gateway, generate certificates, and connect a Windows client.

## Prerequisites
- Azure subscription
- Azure CLI installed and logged in (`az login`)
- A Windows machine for certificate generation and VPN client

## Architecture



## Step-by-Step Instructions

### 1. Create Infrastructure (30‑45 min)
Run the following in Azure CLI (Git Bash or terminal):
```bash
# Variables
resourceGroup="rg-p2s-vpn"
location="eastus"
vnetName="vpn-vnet"
vnetPrefix="10.1.0.0/16"
gatewaySubnetPrefix="10.1.1.0/27"
vmSubnetPrefix="10.1.2.0/24"
gatewayName="vpn-gateway"
gatewayPublicIpName="vpn-gateway-ip"
vpnClientAddressPool="172.16.0.0/24"

# Create resource group
az group create --name $resourceGroup --location $location

# Create VNet and subnets
az network vnet create --resource-group $resourceGroup --name $vnetName --address-prefix $vnetPrefix
az network vnet subnet create --resource-group $resourceGroup --vnet-name $vnetName --name GatewaySubnet --address-prefix $gatewaySubnetPrefix
az network vnet subnet create --resource-group $resourceGroup --vnet-name $vnetName --name vm-subnet --address-prefix $vmSubnetPrefix

# Create public IP for gateway
az network public-ip create --resource-group $resourceGroup --name $gatewayPublicIpName --sku Basic --allocation-method Dynamic

# Create VPN gateway (takes 30‑45 min)
az network vnet-gateway create --resource-group $resourceGroup --name $gatewayName --public-ip-address $gatewayPublicIpName --vnet $vnetName --gateway-type Vpn --vpn-type RouteBased --sku VpnGw1 --no-wait



