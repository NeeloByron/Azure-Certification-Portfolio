# Azure Storage SAS Tokens Lab
In this lab you will learn how to generate Shared Access Signature (SAS) tokens for Azure Storage and test them to verify time‑limited, delegated access. SAS tokens are a crucial security feature that allow you to grant restricted access to storage resources without sharing account keys.
## Prerequisites
- An active Azure subscription.
- A storage account (general purpose v2) – you can create one if you don’t have it.
- Azure CLI installed (`az login`) or Azure PowerShell module (`Connect-AzAccount`).

## Objectives
- Generate a SAS token for a container with read and write permissions.
- Generate a SAS token for a specific blob with read‑only access and an expiry time.

---

## Step 1: Set Up Environment Variables
To make the commands easier, define variables for your resource group, storage account, and container.
### Azure CLI
```bash
RESOURCE_GROUP="myResourceGroup"
STORAGE_ACCOUNT="mystorageaccount"
CONTAINER_NAME="sas-test-container"
BLOB_NAME="sample.txt"
