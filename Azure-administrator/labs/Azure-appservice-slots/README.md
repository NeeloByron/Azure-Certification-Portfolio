# Azure App Service Slots – Web App with Staging Slot and Swap
Deployment slots allow you to test a new version of your web app in a staging environment before swapping it into production with zero downtime. This lab demonstrates how to create a web app with a staging slot, deploy different content to each slot, and perform a swap.

- Create an App Service plan (Standard tier or higher, required for slots).
- Create a production web app and a staging slot.
- Deploy a simple HTML page to both slots.
- Perform a slot swap to promote staging to production.
- Swap back to rollback instantly.

## Architecture

[Internet] → [Production Slot] ← (swap) → [Staging Slot]



- Azure subscription (Contributor or Owner)
- Azure CLI installed and logged in (`az login`)

## Deployment

### Automated Script

The `deploy.sh` script does everything for you:

1. Creates a resource group and App Service plan (Standard S1).
3. Deploys a "version 1" HTML page to production.
4. Deploys a "version 2" HTML page to staging.
5. Swaps staging into production.
6. Displays the URLs for both slots so you can verify.
Run:

```bash
chmod +x deploy.sh
./deploy.sh
