# Bicep Learning – Deploy a Resource Group and Storage Account

## Overview

Bicep is a domain‑specific language (DSL) for deploying Azure resources declaratively. It provides a cleaner syntax than ARM JSON and integrates with the Azure CLI. This lab demonstrates how to write a simple Bicep template that creates a resource group and a storage account.

## What You'll Learn

- Basic Bicep syntax (parameters, resources, outputs).
- How to deploy a Bicep template using Azure CLI.
- How to parameterize a template for flexibility.

## Prerequisites

- Azure subscription (Contributor or Owner)
- Azure CLI installed and logged in (`az login`)

## Bicep Template (main.bicep)

The template below creates a resource group (if not provided, the deployment's resource group) and a storage account.

```bicep
param storageAccountName string = uniqueString(resourceGroup().id)
param location string = resourceGroup().location
param skuName string = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: { name: skuName }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
  }
}

output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name
