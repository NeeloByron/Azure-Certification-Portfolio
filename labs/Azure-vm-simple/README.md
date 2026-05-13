# Azure VM Simple – Deploy a VM with Custom Script Extension

This lab demonstrates how to deploy a Windows virtual machine using Infrastructure as Code (Bicep) and configure it with a custom script extension to install IIS.

## 📋 Objectives

- Deploy a Windows Server 2022 VM with a public IP and network security group allowing RDP.
- Run a PowerShell script via Custom Script Extension to install IIS and create a default web page.
- Use Bicep for declarative infrastructure deployment.

## 📁 Project Structure

- `main.bicep` – Bicep template defining all resources.
- `parameters.json` – Parameter file for admin credentials.
- `deploy.sh` / `deploy.ps1` – Deployment scripts.
- `scripts/install-iis.ps1` – Script executed on the VM.
- `screenshots/` – (Optional) Place for screenshots after deployment.

## 🛠 Prerequisites

- Azure subscription (free trial or paid).
- Azure CLI installed and logged in (`az login`).
- (Optional) PowerShell with Az module for the PowerShell script.

## 🚀 Deployment Instructions

### 1. Clone or navigate to your repository

```bash

