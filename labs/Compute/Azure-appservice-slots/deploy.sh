#!/bin/bash
# Azure App Service Slots - Deploy, Stage, and Swap

set -e

# Variables
resourceGroup="rg-app-slots"
location="eastus"
appName="webapp$RANDOM"
planName="plan-$appName"

echo "=== Azure App Service Slots Demo ==="

# Check login
az account show > /dev/null 2>&1 || az login

# 1. Create resource group
echo "1. Creating resource group..."
az group create --name $resourceGroup --location $location

# 2. Create App Service plan (Standard S1, required for slots)
echo "2. Creating App Service plan (S1)..."
az appservice plan create \
    --resource-group $resourceGroup \
    --name $planName \
    --sku S1

# 3. Create web app
echo "3. Creating web app..."
az webapp create \
    --resource-group $resourceGroup \
    --name $appName \
    --plan $planName

# 4. Create staging slot
echo "4. Creating staging slot..."
az webapp deployment slot create \
    --resource-group $resourceGroup \
    --name $appName \
    --slot staging

# 5. Prepare and deploy version 1 (production)
echo "5. Deploying version 1 to production slot..."
mkdir -p /tmp/deploy-v1
cat > /tmp/deploy-v1/index.html << EOF
<!DOCTYPE html>
<html>
<head><title>App - Version 1</title></head>
<body>
    <h1>Hello from Production Slot (Version 1)</h1>
    <p>This is the original version.</p>
    <p>Swap in progress? Watch this page change.</p>
</body>
</html>
EOF
cd /tmp/deploy-v1
zip app.zip index.html
az webapp deploy \
    --resource-group $resourceGroup \
    --name $appName \
    --src-path app.zip \
    --type zip
cd - > /dev/null
rm -rf /tmp/deploy-v1

# 6. Prepare and deploy version 2 (staging)
echo "6. Deploying version 2 to staging slot..."
mkdir -p /tmp/deploy-v2
cat > /tmp/deploy-v2/index.html << EOF
<!DOCTYPE html>
<html>
<head><title>App - Version 2</title></head>
<body>
    <h1>Hello from Staging Slot (Version 2 – NEW!)</h1>
    <p>This is the updated version ready to go to production.</p>
    <p>After swap, this content will appear on the production URL.</p>
</body>
</html>
EOF
cd /tmp/deploy-v2
zip app.zip index.html
az webapp deploy \
    --resource-group $resourceGroup \
    --name $appName \
    --slot staging \
    --src-path app.zip \
    --type zip
cd - > /dev/null
rm -rf /tmp/deploy-v2

# 7. Show URLs before swap
prodUrl="https://$appName.azurewebsites.net"
stagingUrl="https://$appName-staging.azurewebsites.net"
echo ""
echo "Before swap:"
echo "  Production: $prodUrl (should show Version 1)"
echo "  Staging:    $stagingUrl (should show Version 2)"
echo ""

# 8. Perform the swap
echo "7. Swapping staging into production..."
az webapp deployment slot swap \
    --resource-group $resourceGroup \
    --name $appName \
    --slot staging \
    --target-slot production

# 9. Show URLs after swap
echo ""
echo "Swap completed. Now:"
echo "  Production: $prodUrl (should show Version 2)"
echo "  Staging:    $stagingUrl (should show Version 1)"
echo ""
echo "To swap back (rollback), run:"
echo "  az webapp deployment slot swap -g $resourceGroup -n $appName --slot staging --target-slot production"
echo ""
echo "To clean up:"
echo "  az group delete --name $resourceGroup --yes --no-wait"
