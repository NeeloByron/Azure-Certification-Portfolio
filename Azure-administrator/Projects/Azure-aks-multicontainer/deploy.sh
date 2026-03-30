#!/bin/bash
# Azure AKS Multi‑Container Voting App - Automated Deployment

set -e

# Variables
resourceGroup="rg-aks-voting"
location="eastus"
acrName="acrvoting$RANDOM"
aksCluster="aks-voting"
appName="azure-vote-front"

echo "=== Azure AKS Multi‑Container Voting App ==="

# Check login
az account show > /dev/null 2>&1 || az login

# Create resource group
echo "1. Creating resource group $resourceGroup in $location..."
az group create --name $resourceGroup --location $location

# Create ACR
echo "2. Creating Azure Container Registry $acrName..."
az acr create --resource-group $resourceGroup --name $acrName --sku Basic

# Clone the sample repository (if not already present)
if [ ! -d "aks-voting-app" ]; then
    echo "3. Cloning sample voting app repository..."
    git clone https://github.com/Azure-Samples/aks-voting-app.git
else
    echo "3. Using existing aks-voting-app directory."
fi

cd aks-voting-app/azure-vote

# Build and push image to ACR
echo "4. Building and pushing image to ACR..."
az acr build --registry $acrName --image $appName:v1 .

cd ../..

# Create AKS cluster with ACR attachment
echo "5. Creating AKS cluster $aksCluster (this takes ~10 minutes)..."
az aks create \
    --resource-group $resourceGroup \
    --name $aksCluster \
    --node-count 2 \
    --generate-ssh-keys \
    --attach-acr $acrName

# Get credentials for kubectl
echo "6. Getting kubectl credentials..."
az aks get-credentials --resource-group $resourceGroup --name $aksCluster

# Update the manifest with the correct ACR image name
manifestFile="aks-voting-app/azure-vote-all-in-one-redis.yaml"
echo "7. Updating manifest with image: $acrName.azurecr.io/$appName:v1..."
sed -i "s|mcr.microsoft.com/azuredocs/azure-vote-front:v1|${acrName}.azurecr.io/${appName}:v1|g" $manifestFile

# Apply the manifest
echo "8. Deploying application..."
kubectl apply -f $manifestFile

# Wait for the load balancer to get an external IP
echo "9. Waiting for external IP (may take a few minutes)..."
while true; do
    EXTERNAL_IP=$(kubectl get service azure-vote-front -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null)
    if [ -n "$EXTERNAL_IP" ]; then
        break
    fi
    echo "   Still waiting..."
    sleep 10
done

echo "=== Deployment Complete ==="
echo "Voting app is available at: http://$EXTERNAL_IP"
echo ""
echo "To clean up, run: az group delete --name $resourceGroup --yes --no-wait"
