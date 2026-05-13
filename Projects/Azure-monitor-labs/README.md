# Azure Monitor Labs – Configure Diagnostic Settings and Create a Log Alert

## Overview

This lab demonstrates how to set up monitoring for Azure resources using Azure Monitor. You'll:

- Create a Log Analytics workspace to collect logs.
- Enable diagnostic settings to send Activity Logs (subscription‑level events) to the workspace.
- Create a log alert rule that triggers when a specific event (e.g., starting a virtual machine) occurs.

The alert will send a notification (email) when triggered, helping you detect important administrative actions in your environment.

## What You'll Learn

- How to create and configure a Log Analytics workspace.
- How to enable diagnostic settings for subscription Activity Logs.
- How to create a log alert rule using a Kusto Query Language (KQL) query.
- How to test the alert by performing an action that matches the query.

## Architecture

[Azure Activity Log]
|
| (Diagnostic Setting)
v
[Log Analytics Workspace]
|
| (Log Alert Rule)
v
[Action Group] → (Email notification)


## Prerequisites

- Azure subscription (Contributor or Owner)
- Azure CLI installed and logged in (`az login`)
- A valid email address to receive alerts

## Deployment

### Automated Script

The `deploy.sh` script does everything for you:

1. Creates a resource group.
2. Creates a Log Analytics workspace.
3. Enables diagnostic settings to send subscription Activity Logs to the workspace.
4. Creates a test virtual machine.
5. Creates a log alert that fires when the VM is started.
6. Prompts for your email address and creates an action group for notifications.

Run the script:

```bash
chmod +x deploy.sh
./deploy.sh
