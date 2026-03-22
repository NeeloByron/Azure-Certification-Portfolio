#Full hub-spoke with diagram, Bicep and route tables

# Hub‑Spoke Network with Azure Firewall
This project deploys a hub‑spoke network topology using Bicep. The hub VNet contains Azure Firewall that inspects all outbound traffic from spoke VNets. This architecture is a best practice for centralised security and management in Azure.

[Internet]
+--------------------------------------------------+
| (10.0.0.0/16) |
| +-----------------+ +--------------------+ |
| | AzureFirewall | | Management Subnet | |
| | - Public IP | | (optional) | |
| | - Private IP | +--------------------+ |
| +-----------------+ |
| ^ |
| | (Traffic forced through firewall) |
| v |
+--------------------------------------------------+
| |
+-------------------+ +-------------------+
| +---------------+ | | +---------------+ |


2. The route table on the spoke subnet sends the traffic to the firewall's private IP.

## Prerequisites

- Azure subscription (with permissions to create resources)
- Azure CLI installed and logged in (`az login`)

## Deployment

### Step‑by‑Step (Manual)
2. Deploy with Azure CLI:
```bash
az deployment sub create \
    --location eastus \
    --template-file main.bicep



## 📝 Bicep Template (`main.bicep`)

Below is a complete Bicep template that implements the hub‑spoke architecture. It creates:
- A route table for each spoke subnet that directs all traffic to the firewall's private IP.

```bicep
// main.bicep - Hub‑Spoke with Azure Firewall
param location string = resourceGroup().location
param firewallSubnetPrefix string = '10.0.1.0/24'
  { name: 'spoke1', addressPrefix: '10.1.0.0/16', subnetPrefix: '10.1.1.0/24' }
param firewallName string = 'hub-firewall'
// Resource group assumed to exist (or we can create it in the script)
// Hub VNet
resource hubVnet 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [hubVnetAddressPrefix]
    }
    subnets: [
      {
        name: 'AzureFirewallSubnet'
          addressPrefix: firewallSubnetPrefix
      }
      {
        name: 'ManagementSubnet'
        properties: {
        }
      }
    ]
  }
}

// Firewall public IP
resource fwPublicIp 'Microsoft.Network/publicIPAddresses@2023-02-01' = {
  sku: { name: 'Standard' }
}

// Firewall
resource firewall 'Microsoft.Network/azureFirewalls@2023-02-01' = {
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: hubVnet.properties.subnets[0].id
          publicIPAddress: {
            id: fwPublicIp.id
          }
        }
      }
    ]
  }
  dependsOn: [hubVnet, fwPublicIp]

// Get firewall private IP after deployment

// Loop over spokes
module spokes 'spoke.bicep' = [for spoke in spokeVnets: {
    spokeName: spoke.name
    location: location
    vnetAddressPrefix: spoke.addressPrefix
    hubVnetId: hubVnet.id
    firewallPrivateIp: firewall.properties.ipConfigurations[0].properties.privateIPAddress
  dependsOn: [firewall]
}]

// Optional: firewall application rule to allow example.com
    priority: 100
    action: { type: 'Allow' }
    rules: [
      {
        name: 'AllowExampleCom'
        description: 'Allow outbound HTTPS to example.com'
        ]
        sourceAddresses: ['*']
      }
    ]
  }
}
