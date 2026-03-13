# Azure VM Availability – Deploy Two VMs in an Availability Set

- Create an availability set with fault domains and update domains.
- Optionally assign public IPs to each VM for direct access.
- Run a custom script extension to install IIS and display the VM name.
- Understand how availability sets improve application uptime.
## 📁 Project Structure

- `main.bicep` – Bicep template defining all resources.
- `parameters.json` – Parameter file for admin credentials, VM size, and public IP option.
- `deploy.sh` / `deploy.ps1` – Deployment scripts.
- `scripts/install-iis.ps1` – Script executed on each VM.
- `screenshots/` – (Optional) Place for screenshots after deployment.

## 🛠 Prerequisites

- Azure subscription (free trial or paid).
- Azure CLI installed and logged in (`az login`).
- (Optional) PowerShell with Az module for the PowerShell script.

## 🚀 Deployment Instructions

### 1. Clone or navigate to your repository

```bash
cd ~/Azure-Certification-Portfolio/Azure-administrator/Projects/azure-vm-availability
