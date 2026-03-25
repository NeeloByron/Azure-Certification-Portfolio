#Configure backup for a VM and perform a restore

# Azure Backup Demo – Configure Backup for a VM and Perform a Restore

## Overview

This lab demonstrates how to protect a virtual machine using Azure Backup. You'll create a Recovery Services vault, configure a backup policy, enable backup for a VM, take an on‑demand backup, and then restore a file from that backup.

Azure Backup provides simple, secure, and cost‑effective data protection in Azure. This lab gives you hands‑on experience with the core operations.

## What You'll Learn

- How to create a Recovery Services vault
- How to configure a backup policy (default or custom)
- How to enable backup on a virtual machine
- How to take an on‑demand backup
- How to restore a file from a recovery point
- How to monitor backup jobs

## Architecture

+---------------------------------------------------+
| Azure Subscription |
| |
| +---------------------------------------------+ |
| | Recovery Services Vault | |
| | - Stores backup data | |
| | - Backup policy (daily, weekly, etc.) | |
| +---------------------------------------------+ |
| ^ |
| | (Backup data) |
| v |
| +---------------------------------------------+ |
| | Virtual Machine (protected) | |
| | - Running Windows Server or Linux | |
| +---------------------------------------------+ |
+---------------------------------------------------+


## Prerequisites

- An active Azure subscription (free trial works)
- Azure CLI installed and logged in (`az login`)
- Basic familiarity with the command line

## Step‑by‑Step Instructions (Manual)

You can follow these steps manually to understand each operation.

### 1. Create a Resource Group

```bash
resourceGroup="rg-backup-demo"
location="eastus"
az group create --name $resourceGroup --location $location
