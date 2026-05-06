# Azure Administrator (AZ-104) — Projects & Labs

Hands-on labs and projects mapped to the official [AZ-104 exam objectives](https://learn.microsoft.com/en-us/certifications/resources/study-guides/az-104).
Every entry includes deployment scripts, configurations, and portal screenshots.

---

## 📂 Structure

```
Azure-administrator/
├── Projects/    ← Full end-to-end deployments with automated scripts
└── labs/        ← Focused labs covering individual exam topics
```

---

## 📊 Coverage at a Glance

| AZ-104 Objective | Labs Completed |
|---|---|
| 1 — Identity & Governance | 4 |
| 2 — Storage | 3 |
| 3 — Compute | 6 |
| 4 — Networking | 5 |
| 5 — Monitoring & Maintenance | 4 |
| Advanced / Capstone | 2 |
| **Total** | **24** |

---

## 🔐 Objective 1 — Identity & Governance

| Lab | Description | Skills |
|---|---|---|
| [Azure AD Basics](./labs/Azure-ad-basics/) | Create users and groups via Azure CLI & PowerShell | `Entra ID` `CLI` `PowerShell` |
| [Custom RBAC — VM Operator](./labs/Azure-Custom-RBAC/) | Author and assign a least-privilege custom role | `RBAC` `JSON` `PowerShell` |
| [Policy Demos](./labs/Azure-policy-demos/) | Apply allowed-locations policy via script | `Azure Policy` `Governance` `CLI` |
| [Cost Tags](./labs/Azure-cost-tags/) | Script to apply resource tags and create budget alerts | `Cost Management` `Tags` `Shell` |

---

## 🗄️ Objective 2 — Storage

| Lab | Description | Skills |
|---|---|---|
| [Storage Basics](./labs/Azure-storage-basics/) | Provision storage account, create container, upload blob | `Blob Storage` `Azure CLI` |
| [Storage Advanced](./Projects/Azure-storage-advanced/) | Lifecycle management and private endpoint using Bicep | `Bicep` `Lifecycle Policies` `Private Endpoint` |
| [Storage SAS](./labs/Azure-storage-sas/) | Generate and test Shared Access Signatures | `SAS Tokens` `Access Control` `Security` |

---

## 💻 Objective 3 — Compute

| Lab | Description | Skills |
|---|---|---|
| [VM Simple](./labs/Azure-vm-simple/) | Deploy Linux/Windows VM with PowerShell | `Virtual Machines` `PowerShell` `CLI` |
| [VM Availability](./labs/Azure-vm-availability/) | Configure availability sets and fault domains | `Availability Sets` `PowerShell` `HA` |
| [VMSS Autoscale](./labs/Azure-vmss-autoscale/) | VM Scale Set with CPU-based autoscale rules | `VMSS` `Autoscale` `Monitoring` |
| [App Service Slots](./labs/Azure-appservice-slots/) | Deployment slots for blue/green deployments | `App Service` `Deployment Slots` `PaaS` |
| [ACI Hello](./labs/Azure-aci-hello/) | Run a container in Azure Container Instances | `ACI` `Containers` `Docker` |
| [AKS Multicontainer](./Projects/Azure-aks-multicontainer/) | Deploy a multi-container voting app on AKS with load balancer | `AKS` `Kubernetes` `YAML` `Load Balancer` |

---

## 🌐 Objective 4 — Networking

| Lab | Description | Skills |
|---|---|---|
| [VNet Basics](./labs/Azure-vnet-basics/) | Create VNet, subnets, and peering between two networks | `VNet` `Subnets` `Peering` `Shell` |
| [VPN Point-to-Site](./labs/Azure-vpn-p2s/) | Configure P2S VPN and connect a client | `VPN Gateway` `P2S` `Certificates` |
| [Firewall Demo](./labs/Azure-firewall-demo/) | Deploy Azure Firewall with application rules | `Azure Firewall` `Network Rules` `Security` |
| [Load Balancer](./labs/Azure-loadbalancer-demo/) | Configure a public load balancer across VMs | `Load Balancer` `Backend Pools` `Health Probes` |
| [Hub-Spoke Topology](./Projects/Azure-hub-spoke/) | Enterprise hub-spoke network with automated deployment | `Hub-Spoke` `VNet Peering` `Shell` `Architecture` |

---

## 📈 Objective 5 — Monitoring & Maintenance

| Lab | Description | Skills |
|---|---|---|
| [Monitor Labs](./Projects/Azure-monitor-labs/) | Diagnostic settings, log alerts, Log Analytics workspace | `Azure Monitor` `Log Analytics` `Alerts` |
| [Sentinel Basics](./labs/Azure-sentinel-basics/) | Enable Microsoft Sentinel and connect a data source | `Sentinel` `SIEM` `Security` `Shell` |
| [Backup Demo](./labs/Azure-backup-demo/) | Configure VM backup with Recovery Services Vault | `Azure Backup` `Recovery Vault` `Shell` |
| [Automation Demo](./labs/Azure-automation-demo/) | PowerShell runbook to start/stop VMs on schedule | `Automation Account` `Runbooks` `PowerShell` |

---

## 🚀 Advanced / Capstone Projects

| Project | Description | Skills |
|---|---|---|
| [Azure Full App](./Projects/Azure-full-app/) | Full application deployment via main Bicep script | `Bicep` `IaC` `End-to-End Deployment` |
| [Bicep Learning](./labs/bicep-learning/) | Progressive Bicep templates for Azure resource automation | `Bicep` `IaC` `ARM` `Automation` |

---

## 📚 Resources

- [Microsoft Learn — AZ-104](https://learn.microsoft.com/en-us/certifications/azure-administrator/)
- [AZ-104 Official Study Guide](https://learn.microsoft.com/en-us/certifications/resources/study-guides/az-104)
- [John Savill's AZ-104 Exam Cram](https://www.youtube.com/@NTFAQGuy)

---

<sub>24 labs completed · All work done on live Azure subscriptions · Last updated May 2026</sub>
