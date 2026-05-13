# Azure Full‑Stack Application – Multi‑Tier App with VNet Integration, Private Endpoints, and Monitoring

## Overview

This project deploys a secure, monitored, multi‑tier application on Azure using Infrastructure as Code (Bicep). The architecture consists of:

- **Azure App Service** (web frontend) with VNet integration.
- **Azure SQL Database** (backend database) with a private endpoint.
- **Virtual Network** with two subnets: one for the web app integration and one for the database private endpoint.
- **Private DNS Zones** to resolve the private endpoints.
- **Application Insights** for performance monitoring and diagnostics.
- **Diagnostic Settings** to send logs to a Log Analytics workspace.

All components are deployed in a secure, isolated environment – the web app is accessible via the internet, but the database is only accessible from within the virtual network.

## Architecture

[Internet User]
|
v
+-----------------------------------------------------+
| App Service (Web App) |
| - Public endpoint (https://...) |
| - VNet Integration (outbound) |
+-----------------------------------------------------+
|
| (Private IP via VNet Integration)
v
+-----------------------------------------------------+
| Virtual Network |
| +------------------+ +----------------------+ |
| | Integration | | Private Endpoint | |
| | Subnet | | Subnet | |
| | (10.0.1.0/24) | | (10.0.2.0/24) | |
| +------------------+ +----------------------+ |
| | | |
| v v |
+-----------------------------------------------------+
| SQL Database |
| - Private endpoint |
| - Only accessible from within VNet |
+-----------------------------------------------------+


**Traffic Flow**:
- Users access the web app via its public URL.
- The web app uses VNet integration to connect to the database via the private endpoint.
- The database is isolated – it has no public endpoint.
- All traffic is secured within the virtual network.

## Prerequisites

- Azure subscription (Owner or Contributor permissions)
- Azure CLI installed and logged in (`az login`)

## Deployment

