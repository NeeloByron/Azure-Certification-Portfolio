# Azure AKS Multi-Container Voting App
This project demonstrates how to deploy a multi-container application to a production-like environment on Azure using Kubernetes. You will containerize a sample voting application, store its images in a private Azure Container Registry (ACR), and then deploy and run it on an Azure Kubernetes Service (AKS) cluster. The application is exposed to the internet using an Azure Load Balancer.
## What You'll Learn

-   How to build container images for a multi-service application (frontend + backend).
-   How to securely link an AKS cluster with an ACR to pull private images.
## Prerequisites

-   An active **Azure subscription** (free trial works).
-   **Docker** installed on your local machine.
-   **kubectl** installed (`az aks install-cli`).
## The Application

We will use a simple but classic voting application example. Its architecture consists of:
-   **Azure Vote Frontend**: A Python/Flask web application that presents the voting interface.
The source code and Kubernetes manifests for this app are available from Microsoft's official Azure Samples repository [citation:8].

### 1. Set Up Environment Variables

To make the commands easier to run and reuse, define the following variables in your terminal. Replace the placeholder values with your own unique choices.
RESOURCE_GROUP="rg-aks-voting-app"
LOCATION="eastus"

# ACR (must be globally unique)

# AKS Cluster
AKS_CLUSTER_NAME="aks-voting-cluster"
