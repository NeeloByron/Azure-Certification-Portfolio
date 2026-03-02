# Azure Projects

## Azure Projects – Advanced Hands‑On Labs

---

## Advanced Projects (Employer‑Ready)

These projects go beyond simple examples. They integrate multiple Azure services, follow infrastructure‑as‑code principles, and solve realistic business problems.

### 1. azure-storage-advanced
**Description:**  
Implements a secure, cost‑optimised Azure Storage solution with lifecycle management, private endpoints, and geo‑replication.

**Key technologies:**  
Storage Accounts, Lifecycle Policies, Private Endpoints, Bicep/ARM

**What makes it impressive:**  
- Demonstrates security best practices by isolating storage from the public internet using private endpoints.  
- Automates data tiering and deletion with lifecycle rules – a common cost‑saving requirement in enterprises.  
- Entire infrastructure defined as code (Bicep), proving ability to version and automate deployments.

---

### 2. azure-aks-multicontainer
**Description:**  
Deploys a multi‑container voting application on Azure Kubernetes Service (AKS) with an Azure Load Balancer and includes an architecture diagram.
**Key technologies:**  
AKS, Azure Load Balancer, Docker, Kubernetes manifests, Ingress (optional)

**What makes it impressive:**  
- Shows proficiency in container orchestration – a highly sought‑after skill.  
- Configures a load balancer to expose the application externally, simulating real‑world traffic management.  
- Includes a clear architecture diagram, proving you can design and communicate complex solutions.  

---

### 3. azure-hub-spoke
**Description:**  
Builds a complete hub‑spoke network topology with Azure Firewall, route tables, and VNet peering, all defined in Bicep and accompanied by a diagram.
**Key technologies:**  
Hub‑Spoke Architecture, Azure Firewall, VNet Peering, Route Tables, Bicep

**What makes it impressive:**  
- Mirrors enterprise network designs commonly used to secure and govern multi‑workload environments.  
- Uses route tables to control traffic flow between spokes and hub – a critical skill for any Azure administrator.  
- Full infrastructure as code (Bicep) makes the solution repeatable and auditable.  
- The included diagram helps others understand the topology at a glance.

---

### 4. azure-monitor-labs
**Description:**  
Sets up comprehensive monitoring for an Azure environment: diagnostic settings, log alerts, Log Analytics queries, and action groups.
**Key technologies:**  
Azure Monitor, Log Analytics, Action Groups, KQL (Kusto Query Language)

**What makes it impressive:**  
- Proves ability to operationalise Azure – detect issues, visualise data, and respond automatically.  
- Configures diagnostic settings to collect logs and metrics from multiple resources, a prerequisite for any production environment.  
- Creates log alerts based on KQL queries, demonstrating proficiency in Log Analytics and alerting.  
- Includes action groups to notify or trigger automated responses, showing understanding of incident response workflows.

---

### 5. azure-full-app
**Description:**  
Deploys a multi‑tier application (web app + database) with VNet integration, private endpoints, and end‑to‑end monitoring, all documented with a diagram and Bicep.
**Key technologies:**  
App Service, SQL Database, VNet Integration, Private Endpoints, Azure Monitor, Bicep

**What makes it impressive:**  
- Combines compute, networking, security, and observability into one coherent solution – a true “full‑stack” Azure project.  
- Uses VNet integration and private endpoints to secure communication between tiers, demonstrating advanced networking and security practices.  
- Includes monitoring for all components, showing a holistic approach to application operations.  
- The architecture diagram and Bicep templates make the solution easy to understand and replicate.  
- This project closely resembles a real‑world application deployment, making it highly relevant to employers.
---

## Folder Structure

Each project folder follows a consistent layout:
#

