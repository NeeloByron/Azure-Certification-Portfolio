# Azure Container Instances (ACI) – Deploy a Simple Container

## Overview

This lab demonstrates how to deploy a single container to **Azure Container Instances (ACI)**, a serverless container platform. You'll deploy a public Nginx web server, expose it to the internet, and verify that it's running.

ACI is ideal for simple, fast container deployments without the overhead of managing virtual machines or orchestrators like Kubernetes.

## What You'll Learn

- Create a resource group.
- Deploy a container from Docker Hub using the Azure CLI.
- Assign a public DNS name to the container.
- View container logs and state.
- Clean up resources.

## Prerequisites

- An Azure subscription (free trial works).
- Azure CLI installed and logged in (`az login`).

## Step‑by‑Step Instructions

### 1. Set variables

Choose a unique DNS label (the subdomain part of the URL). The `$RANDOM` trick helps avoid conflicts.

```bash
resourceGroup="rg-aci-hello"
location="eastus"
dnsLabel="nginx-aci-$RANDOM"
containerName="mynginx"
image="nginx:latest"

