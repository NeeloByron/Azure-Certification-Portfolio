# Azure Automation Demo – Start/Stop VM with Runbook and Schedule

## Overview

This lab demonstrates how to use Azure Automation to start and stop a virtual machine on a schedule. You’ll create an Automation Account, a test VM, a PowerShell runbook, and a daily schedule. The runbook uses the Automation Account’s system‑assigned managed identity to authenticate without storing credentials.

## What You'll Learn

- Create an Automation Account and enable its managed identity.
- Grant the identity permissions to start/stop a VM.
- Create and publish a PowerShell runbook.
- Link a schedule to the runbook.

## Prerequisites

- Azure subscription (Owner or Contributor)
- Azure CLI installed and logged in (`az login`)

## Architecture

[Azure Automation Account] → (managed identity) → [Test VM]


## Step‑by‑Step Instructions

The provided `deploy.sh` script automates everything:

1. Clone or download the script.
2. Run `chmod +x deploy.sh` and then `./deploy.sh`.
3. After completion, the test VM will be stopped daily at 18:00 UTC.

You can also test the runbook manually:

```bash
az automation runbook start \
  -g rg-automation-demo \
  --automation-account-name myAutomationAccount \
  -n Start-Stop-VM \
  --parameters '{"VMName":"testvm","Action":"Start"}'
