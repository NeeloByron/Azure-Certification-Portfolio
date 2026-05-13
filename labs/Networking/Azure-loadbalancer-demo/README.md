# Azure Load Balancer Demo: VMSS Behind a Public Load Balancer

## Overview

This lab demonstrates how to deploy a scalable and highly available web application on Azure. You will create a Virtual Machine Scale Set (VMSS) running a simple web server and place it behind a public Azure Load Balancer. The load balancer will distribute incoming user traffic across all the VM instances, ensuring that your application remains available even if a single instance fails.

This is a core architectural pattern for building resilient applications in the cloud.

## What You'll Learn

- How to create a Virtual Network (VNet) and a subnet.
- How to provision a Standard Public IP address.
- How to create and configure an Azure Load Balancer, including its frontend IP, backend pool, health probe, and load balancing rule.
- How to deploy a Virtual Machine Scale Set (VMSS) and integrate it with an existing load balancer.
- How to use a custom script extension to automatically install and configure a web server (Apache2) on each VM instance.
- How to test the load-balanced application and observe traffic distribution.

## Prerequisites

- An active **Azure subscription** (a free trial works).
- **Azure CLI** installed and configured (`az login`). You can also use the Azure Cloud Shell from the portal.
- Basic familiarity with the command line.

## Architecture

[Internet User]
|
| (HTTP Traffic on port 80)
v
+---------------------------------------------------+
| Azure Load Balancer (Standard) |
| - Frontend IP: Your Public IP |
| - Health Probe: Checks port 80 on / |
| - Load Balancing Rule: Forwards traffic on port 80|
+---------------------------------------------------+
| | |
| (Traffic Distributed) |
v v v
+-----------------+ +-----------------+ +-----------------+
| VMSS Instance 1| | VMSS Instance 2| | VMSS Instance 3|
| (Apache Web | | (Apache Web | | (Apache Web |
| Server) | | Server) | | Server) |
+-----------------+ +-----------------+ +-----------------+
|
v
+---------------------------------------------------+
| Virtual Network |
| Subnet |
+---------------------------------------------------+


## Step-by-Step Instructions (Using Azure CLI)

We will build this infrastructure step-by-step. You can copy and paste these commands into your terminal.

### 1. Set Up Environment Variables

First, define variables to make the commands easier to run and reuse.

```bash
# Resource Group
resourceGroup="rg-loadbalancer-demo"
location="eastus"

# Networking
vnetName="app-vnet"
subnetName="app-subnet"
vnetAddressPrefix="10.0.0.0/16"
subnetPrefix="10.0.1.0/24"

# Load Balancer
lbName="webapp-lb"
publicIpName="webapp-public-ip"
frontendIpName="lb-frontend"
backendPoolName="lb-backend-pool"
healthProbeName="http-health-probe"
lbRuleName="http-rule"

# VM Scale Set
vmssName="webapp-vmss"
vmSku="Standard_DS1_v2"
instanceCount="2"
adminUser="azureuser"

