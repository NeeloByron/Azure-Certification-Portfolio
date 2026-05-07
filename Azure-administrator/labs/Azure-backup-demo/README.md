# Azure Backup Demo — Configure Backup for a VM and Perform a Restore

> **AZ-104 Objective 5:** Monitor and maintain Azure resources  
> **Skills demonstrated:** `Azure Backup` `Recovery Services Vault` `Backup Policy` `File Restore` `Azure CLI`

---

## 📋 Overview

Hands-on lab demonstrating how to protect a Virtual Machine using Azure Backup.
Covers creating a Recovery Services vault, configuring a backup policy, enabling backup on a VM,
taking an on-demand backup, restoring a file from a recovery point, and monitoring backup jobs.

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────┐
│                Azure Subscription                │
│                                                  │
│   ┌──────────────────────────────────────────┐   │
│   │         Recovery Services Vault           │   │
│   │  - Stores all backup data                │   │
│   │  - Backup policy (daily / weekly)        │   │
│   └──────────────────┬───────────────────────┘   │
│                      │ backup data               │
│                      ▼                           │
│   ┌──────────────────────────────────────────┐   │
│   │         Virtual Machine (protected)       │   │
│   │  - Windows Server or Linux               │   │
│   │  - Backup agent installed automatically  │   │
│   └──────────────────────────────────────────┘   │
│                                                  │
└─────────────────────────────────────────────────┘
```

---

## 🎯 What You'll Learn

- Create a Recovery Services vault
- Configure a backup policy (default or custom schedule)
- Enable backup on a Virtual Machine
- Take an on-demand backup
- Restore a file from a recovery point
- Monitor backup jobs in Azure Monitor

---

## ✅ Prerequisites

- Active Azure subscription (free trial works)
- Azure CLI installed and logged in — `az login`
- Basic familiarity with the command line

---

## 🚀 Automated Deployment

Run the deploy script to provision all resources automatically:

```bash
chmod +x deploy.sh
./deploy.sh
```

📁 [View deploy.sh](./deploy.sh)

---

## 🪜 Manual Step-by-Step

Follow these steps to understand each operation individually.

### Step 1 — Create a Resource Group

```bash
resourceGroup="rg-backup-demo"
location="eastus"

az group create \
  --name $resourceGroup \
  --location $location
```

### Step 2 — Create a Recovery Services Vault

```bash
vaultName="vault-backup-demo"

az backup vault create \
  --resource-group $resourceGroup \
  --name $vaultName \
  --location $location
```

### Step 3 — Create a Virtual Machine to Protect

```bash
vmName="vm-backup-demo"

az vm create \
  --resource-group $resourceGroup \
  --name $vmName \
  --image Win2019Datacenter \
  --admin-username azureuser \
  --admin-password "YourPassword123!"
```

### Step 4 — Enable Backup on the VM

```bash
az backup protection enable-for-vm \
  --resource-group $resourceGroup \
  --vault-name $vaultName \
  --vm $vmName \
  --policy-name DefaultPolicy
```

### Step 5 — Trigger an On-Demand Backup

```bash
az backup protection backup-now \
  --resource-group $resourceGroup \
  --vault-name $vaultName \
  --container-name $vmName \
  --item-name $vmName \
  --retain-until 30-11-2026 \
  --backup-management-type AzureIaasVM
```

### Step 6 — Monitor the Backup Job

```bash
az backup job list \
  --resource-group $resourceGroup \
  --vault-name $vaultName \
  --output table
```

### Step 7 — List Recovery Points

```bash
az backup recoverypoint list \
  --resource-group $resourceGroup \
  --vault-name $vaultName \
  --container-name $vmName \
  --item-name $vmName \
  --backup-management-type AzureIaasVM \
  --output table
```

### Step 8 — Restore a File from Backup

In the Azure Portal:
1. Go to **Recovery Services Vault** → **Backup Items**
2. Select your VM → **File Recovery**
3. Choose a recovery point
4. Download and run the recovery script on the VM
5. Browse the mounted recovery volume and copy the file

### Step 9 — Clean Up Resources

```bash
az group delete --name $resourceGroup --yes --no-wait
```

---

## 📸 Screenshots

| Screenshot | Description |
|---|---|
| `01-vault-created.png` | Recovery Services vault provisioned |
| `02-backup-enabled.png` | VM backup protection enabled |
| `03-backup-job.png` | On-demand backup job completed |
| `04-recovery-point.png` | Recovery point listed in vault |

---

## 💡 Key Takeaways

- Azure Backup uses the **DefaultPolicy** (daily backup, 30-day retention) out of the box — no custom config needed to get started
- The Recovery Services vault and the VM **must be in the same region**
- On-demand backups don't replace scheduled backups — they run independently
- File-level restore is faster than full VM restore for recovering individual files

---

## 🔗 References

- [Microsoft Learn — Back up Azure VMs](https://learn.microsoft.com/en-us/azure/backup/backup-azure-vms-introduction)
- [AZ-104 Study Guide — Objective 5](https://learn.microsoft.com/en-us/certifications/resources/study-guides/az-104)
