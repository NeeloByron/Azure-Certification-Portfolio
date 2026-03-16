# Azure App Service Slots Lab

## Overview

This lab demonstrates how to use **deployment slots** in Azure App Service to implement **zero-downtime deployments** and **instant rollback**. You will:

- Create an Azure Web App with a production slot.
- Deploy an initial version of a simple website.
- Create a **staging** deployment slot.
- Deploy an updated version of the website to the staging slot.
- Perform a **slot swap** to promote the new version to production without any downtime.
- Verify the swap and then swap back to simulate an instant rollback.

This pattern (often called **blue-green deployment**) is a critical skill for any cloud administrator or DevOps engineer, as it minimises deployment risks and ensures high availability.

## Prerequisites

- An active **Azure subscription** (free trial works).
- **Azure CLI** installed and logged in (`az login`).
- Basic familiarity with the command line.

## Step‑by‑Step Instructions

We will use Azure CLI commands. You can also perform these steps in the Azure portal, but using CLI allows you to automate the entire process.

### 1. Set Up Variables and Resource Group

Choose a unique name for your app (the `$RANDOM` adds randomness to avoid name conflicts).

```bash
# Variables
resourceGroup="rg-appservice-slots"
location="eastus"
appName="mywebapp$RANDOM"
appServicePlan="asp-$appName"

# Create resource group
az group create --name $resourceGroup --location $location

