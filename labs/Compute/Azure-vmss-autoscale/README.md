# Azure VMSS Autoscale Lab

## Overview

This lab demonstrates how to configure **autoscaling** for an Azure Virtual Machine Scale Set (VMSS) based on CPU performance metrics. You will deploy a VMSS, define rules to automatically add or remove VM instances in response to CPU load, and then simulate high CPU usage to see the scaling in action.

This is a core operational skill for managing cost and performance in dynamic cloud environments and is a key topic for the AZ-104 exam.

## Prerequisites

- An active **Azure subscription** (free trial works).
- **Azure CLI** installed and logged in (`az login`).
- Basic familiarity with the command line.

## Step-by-Step Instructions

We will use Azure CLI commands. You can also perform these steps in the Azure portal, but using the CLI allows you to script and automate the process, which is a valuable skill.

### 1. Set Up Variables and Resource Group

First, let's define some variables to make the commands easier to run and reuse. This creates a unique name for your scale set and a resource group to hold all related resources.

```bash
# Variables - feel free to change these
resourceGroup="rg-vmss-autoscale"
location="eastus"
vmssName="vmss-cpu-autoscale"
adminUser="azureuser"

