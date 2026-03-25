# Azure Cost Management – Apply Tags and Create a Budget Alert

## Overview

Tags are key‑value pairs that help you organize and manage your Azure resources. Budget alerts allow you to monitor spending and get notified when costs approach or exceed predefined thresholds. This lab demonstrates how to apply tags to resources and create a budget alert using the Azure CLI.

## What You'll Learn

- How to apply tags to a resource group and a virtual machine.
- How to use tags to categorize resources (e.g., by environment or project).
- How to create a subscription‑level budget alert with a notification email.
- How to monitor costs in Azure Cost Management.

## Prerequisites

- An active Azure subscription (free trial works).
- **Contributor** or higher permissions on the subscription (to create budgets).
- Azure CLI installed and logged in (`az login`).

## Step‑by‑Step Instructions (Manual)

Follow these steps manually to understand the process.

### 1. Create Resources with Tags

```bash
resourceGroup="rg-cost-demo"
location="eastus"

az group create --name $resourceGroup --location $location --tags Environment=Test Project=CostDemo

az vm create \
    --resource-group $resourceGroup \
    --name "costvm" \
    --image Ubuntu2204 \
    --admin-username azureuser \
    --generate-ssh-keys \
    --tags Environment=Test Project=CostDemo
