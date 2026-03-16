
```bash
#!/bin/bash
resourceGroup="rg-aci-hello"
location="eastus"
dnsLabel="nginx-aci-$RANDOM"
containerName="mynginx"
image="nginx:latest"

az group create --name $resourceGroup --location $location

az container create \
  --resource-group $resourceGroup \
  --name $containerName \
  --image $image \
  --dns-name-label $dnsLabel \
  --ports 80 \
  --cpu 1 \
  --memory 1.5


