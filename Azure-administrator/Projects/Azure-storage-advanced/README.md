# Azure Storage Advanced Project

## Overview
This project demonstrates how to deploy a secure, cost‑optimized Azure Storage account using Infrastructure as Code (Bicep). It includes:
- A storage account with geo‑replication (Standard_GRS).
- Lifecycle management rules to automatically tier blobs to Cool and Archive tiers based on age.
- A private endpoint to connect to the blob service from a virtual network, ensuring the storage account is not exposed to the public internet.

## Architecture
![Architecture Diagram](./diagrams/architecture.png)  
*(Add a diagram if you have one)*

## Technologies Used
- Bicep / ARM
- Azure Storage (blob)
- Private Endpoints
- Virtual Network
- Lifecycle Management Policies

## Prerequisites
- An Azure subscription
- Azure CLI installed and logged in (`az login`)
- Git (to clone the repository)

## Deployment Instructions

1. Clone the repository and navigate to this project folder:
   ```bash
   git clone <your-repo-url>
   cd Azure-administrator/Projects/azure-storage-advanced

