<div align="center">

# ☁️ Azure Certification Portfolio

[![AZ-900](https://img.shields.io/badge/AZ--900-Certified_Feb_2026-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white)](https://www.credly.com/users/neelo-nkhuna)
[![AZ-104](https://img.shields.io/badge/AZ--104-In_Progress_2026-orange?style=for-the-badge&logo=microsoft-azure&logoColor=white)](https://learn.microsoft.com/en-us/certifications/azure-administrator/)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/neelo-nkhuna-ba2b9b115/)

*24 hands-on labs and projects covering all 5 AZ-104 exam objectives.*  
*Every lab includes deployment scripts, configurations, and portal screenshots.*

</div>

---

## 🏅 Certifications

| Certification | Status | Date |
|---|---|---|
| AZ-900 — Azure Fundamentals | ✅ Passed | Feb 2026 |
| AZ-104 — Azure Administrator Associate | 🔄 In Progress | Est. 2026 |

---

## 📊 Lab Coverage by Exam Objective

| AZ-104 Objective | Labs Completed |
|---|---|
| 1 — Identity & Governance | 4 |
| 2 — Storage | 3 |
| 3 — Compute | 6 |
| 4 — Networking | 5 |
| 5 — Monitoring & Maintenance | 4 |
| Advanced / Capstone Projects | 2 |
| **Total** | **24** |

---

## 🧪 Labs & Projects

All work lives in [`/Azure-administrator`](./Azure-administrator/).

---

### 🔐 Objective 1 — Identity & Governance

| Lab | Description | Skills |
|---|---|---|
| [Azure AD Basics](./Azure-administrator/labs/Azure-ad-basics/) | Create users and groups via Azure CLI & PowerShell | `Entra ID` `CLI` `PowerShell` |
| [Custom RBAC — VM Operator](./Azure-administrator/labs/Azure-Custom-RBAC/) | Author and assign a least-privilege custom role | `RBAC` `JSON` `PowerShell` |
| [Policy Demos](./Azure-administrator/labs/Azure-policy-demos/) | Apply allowed-locations policy via script | `Azure Policy` `Governance` `CLI` |
| [Cost Tags](./Azure-administrator/labs/Azure-cost-tags/) | Script to apply resource tags and create budget alerts | `Cost Management` `Tags` `Shell` |

---

### 🗄️ Objective 2 — Storage

| Lab | Description | Skills |
|---|---|---|
| [Storage Basics](./Azure-administrator/labs/Azure-storage-basics/) | Provision storage account, create container, upload blob | `Blob Storage` `Azure CLI` |
| [Storage Advanced](./Azure-administrator/Projects/Azure-storage-advanced/) | Lifecycle management and private endpoint using Bicep | `Bicep` `Lifecycle Policies` `Private Endpoint` |
| [Storage SAS](./Azure-administrator/labs/Azure-storage-sas/) | Generate and test Shared Access Signatures | `SAS Tokens` `Access Control` `Security` |

---

### 💻 Objective 3 — Compute

| Lab | Description | Skills |
|---|---|---|
| [VM Simple](./Azure-administrator/labs/Azure-vm-simple/) | Deploy Linux/Windows VM with PowerShell | `Virtual Machines` `PowerShell` `CLI` |
| [VM Availability](./Azure-administrator/labs/Azure-vm-availability/) | Configure availability sets and fault domains | `Availability Sets` `PowerShell` `HA` |
| [VMSS Autoscale](./Azure-administrator/labs/Azure-vmss-autoscale/) | VM Scale Set with CPU-based autoscale rules | `VMSS` `Autoscale` `Monitoring` |
| [App Service Slots](./Azure-administrator/labs/Azure-appservice-slots/) | Deployment slots for blue/green deployments | `App Service` `Deployment Slots` `PaaS` |
| [ACI Hello](./Azure-administrator/labs/Azure-aci-hello/) | Run a container in Azure Container Instances | `ACI` `Containers` `Docker` |
| [AKS Multicontainer](./Azure-administrator/Projects/Azure-aks-multicontainer/) | Deploy a multi-container voting app on AKS with load balancer | `AKS` `Kubernetes` `YAML` `Load Balancer` |

---

### 🌐 Objective 4 — Networking

| Lab | Description | Skills |
|---|---|---|
| [VNet Basics](./Azure-administrator/labs/Azure-vnet-basics/) | Create VNet, subnets, peering between two networks | `VNet` `Subnets` `Peering` `Shell` |
| [VPN Point-to-Site](./Azure-administrator/labs/Azure-vpn-p2s/) | Configure P2S VPN and connect a client | `VPN Gateway` `P2S` `Certificates` |
| [Firewall Demo](./Azure-administrator/labs/Azure-firewall-demo/) | Deploy Azure Firewall with application rules | `Azure Firewall` `Network Rules` `Security` |
| [Load Balancer](./Azure-administrator/labs/Azure-loadbalancer-demo/) | Configure a public load balancer across VMs | `Load Balancer` `Backend Pools` `Health Probes` |
| [Hub-Spoke Topology](./Azure-administrator/Projects/Azure-hub-spoke/) | Enterprise hub-spoke network with deploy.sh automation | `Hub-Spoke` `VNet Peering` `Shell` `Architecture` |

---

### 📈 Objective 5 — Monitoring & Maintenance

| Lab | Description | Skills |
|---|---|---|
| [Monitor Labs](./Azure-administrator/Projects/Azure-monitor-labs/) | Diagnostic settings, log alerts, Log Analytics workspace | `Azure Monitor` `Log Analytics` `Alerts` |
| [Sentinel Basics](./Azure-administrator/labs/Azure-sentinel-basics/) | Enable Microsoft Sentinel and connect a data source | `Sentinel` `SIEM` `Security` `Shell` |
| [Backup Demo](./Azure-administrator/labs/Azure-backup-demo/) | Configure VM backup with Recovery Services Vault | `Azure Backup` `Recovery Vault` `Shell` |
| [Automation Demo](./Azure-administrator/labs/Azure-automation-demo/) | PowerShell runbook to start/stop VMs on schedule | `Automation Account` `Runbooks` `PowerShell` |

---

### 🚀 Advanced / Capstone Projects

| Project | Description | Skills |
|---|---|---|
| [Azure Full App](./Azure-administrator/Projects/Azure-full-app/) | Full application deployment via main Bicep script | `Bicep` `IaC` `End-to-End Deployment` |
| [Bicep Learning](./Azure-administrator/labs/bicep-learning/) | Progressive Bicep templates for Azure resource automation | `Bicep` `IaC` `ARM` `Automation` |

---

## 🛠️ Tools & Technologies

![Azure Portal](https://img.shields.io/badge/Azure_Portal-0089D6?style=flat-square&logo=microsoft-azure&logoColor=white)
![Azure CLI](https://img.shields.io/badge/Azure_CLI-0089D6?style=flat-square&logo=microsoft-azure&logoColor=white)
![Bicep](https://img.shields.io/badge/Bicep-0089D6?style=flat-square&logo=microsoft-azure&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat-square&logo=powershell&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
![Shell](https://img.shields.io/badge/Shell_Script-121011?style=flat-square&logo=gnu-bash&logoColor=white)
![Microsoft Entra ID](https://img.shields.io/badge/Entra_ID-0089D6?style=flat-square&logo=microsoft&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

---

## 📚 Study Resources

- [Microsoft Learn — AZ-104](https://learn.microsoft.com/en-us/certifications/azure-administrator/)
- [AZ-104 Official Study Guide](https://learn.microsoft.com/en-us/certifications/resources/study-guides/az-104)
- [John Savill's AZ-104 Exam Cram](https://www.youtube.com/@NTFAQGuy)

---

<div align="center">
<sub>24 labs completed · All work done on live Azure subscriptions · Last updated May 2026</sub>
</div>
