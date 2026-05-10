# Azure Automation Demo — Start/Stop VM with Runbook and Schedule

> **AZ-104 Objective 5:** Monitor and maintain Azure resources  
> **Skills demonstrated:** `Azure Automation` `PowerShell Runbook` `Managed Identity` `Schedules` `RBAC` `Azure CLI`

---

## 📋 Overview

Hands-on lab demonstrating how to use Azure Automation to start and stop a Virtual Machine
on a daily schedule. Uses a system-assigned managed identity for credential-free authentication
— no passwords or service principal secrets stored anywhere.

---

## 🏗️ Architecture

```
┌──────────────────────────────────────────────────────────┐
│                    Azure Subscription                     │
│                                                          │
│   ┌─────────────────────────────────────────────────┐   │
│   │            Azure Automation Account              │   │
│   │                                                  │   │
│   │  ┌─────────────────┐   ┌──────────────────────┐ │   │
│   │  │  PowerShell     │   │  Daily Schedule       │ │   │
│   │  │  Runbook        │◄──│  (18:00 UTC)          │ │   │
│   │  │  Start-Stop-VM  │   └──────────────────────┘ │   │
│   │  └────────┬────────┘                             │   │
│   │           │ Managed Identity (no passwords)      │   │
│   └───────────┼──────────────────────────────────────┘   │
│               │ VM Contributor role                       │
│               ▼                                          │
│   ┌─────────────────────────────────────────────────┐   │
│   │              Virtual Machine (testvm)            │   │
│   │         Started / Stopped on schedule            │   │
│   └─────────────────────────────────────────────────┘   │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

---

## 🎯 What You'll Learn

- Create an Azure Automation Account
- Enable and use a system-assigned managed identity
- Assign RBAC roles to a managed identity
- Write and publish a PowerShell runbook
- Create a recurring schedule and link it to a runbook
- Pass parameters to a scheduled runbook

---

## ✅ Prerequisites

- Azure subscription with Owner or Contributor access
- Azure CLI installed and logged in — `az login`
- Basic familiarity with PowerShell syntax

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

### Step 1 — Create a Resource Group

```bash
az group create \
    --name rg-automation-demo \
    --location eastus
```

### Step 2 — Create an Automation Account

```bash
az automation account create \
    --resource-group rg-automation-demo \
    --name myAutomationAccount \
    --location eastus \
    --sku Basic
```

### Step 3 — Enable System-Assigned Managed Identity

```bash
az automation account update \
    --resource-group rg-automation-demo \
    --name myAutomationAccount \
    --assign-identity
```

### Step 4 — Create a Test VM

```bash
az vm create \
    --resource-group rg-automation-demo \
    --name testvm \
    --image Ubuntu2204 \
    --admin-username azureuser \
    --generate-ssh-keys \
    --public-ip-sku Standard
```

### Step 5 — Assign VM Contributor Role to Managed Identity

```bash
principalId=$(az automation account show \
    --resource-group rg-automation-demo \
    --name myAutomationAccount \
    --query identity.principalId --output tsv)

vmId=$(az vm show \
    --resource-group rg-automation-demo \
    --name testvm \
    --query id --output tsv)

az role assignment create \
    --assignee $principalId \
    --role "Virtual Machine Contributor" \
    --scope $vmId
```

### Step 6 — Create and Publish the Runbook

```bash
az automation runbook create \
    --resource-group rg-automation-demo \
    --automation-account-name myAutomationAccount \
    --name Start-Stop-VM \
    --type PowerShell

az automation runbook publish \
    --resource-group rg-automation-demo \
    --automation-account-name myAutomationAccount \
    --name Start-Stop-VM
```

### Step 7 — Create a Daily Schedule

```bash
az automation schedule create \
    --resource-group rg-automation-demo \
    --automation-account-name myAutomationAccount \
    --name DailyStop \
    --frequency Day \
    --interval 1 \
    --start-time "2026-06-01T18:00:00Z" \
    --time-zone UTC
```

### Step 8 — Test the Runbook Manually

```bash
# Start the VM
az automation runbook start \
    -g rg-automation-demo \
    --automation-account-name myAutomationAccount \
    -n Start-Stop-VM \
    --parameters '{"VMName":"testvm","Action":"Start"}'

# Stop the VM
az automation runbook start \
    -g rg-automation-demo \
    --automation-account-name myAutomationAccount \
    -n Start-Stop-VM \
    --parameters '{"VMName":"testvm","Action":"Stop"}'
```

### Step 9 — Clean Up

```bash
az group delete --name rg-automation-demo --yes --no-wait
```

---


## 💡 Key Takeaways

- Managed identity eliminates the need to store credentials in runbooks — the Automation Account authenticates as itself using its Azure AD identity
- The VM Contributor role is scoped to the specific VM resource, not the whole subscription — this is least-privilege in practice
- Schedules and runbooks are independent — one schedule can trigger multiple runbooks, and one runbook can be triggered by multiple schedules
- Always test runbooks manually before attaching a schedule to catch errors early

---

## 🔗 References

- [Microsoft Learn — Azure Automation overview](https://learn.microsoft.com/en-us/azure/automation/overview)
- [Microsoft Learn — Managed identities for Automation](https://learn.microsoft.com/en-us/azure/automation/automation-security-overview)
- [AZ-104 Study Guide — Objective 5](https://learn.microsoft.com/en-us/certifications/resources/study-guides/az-104)
