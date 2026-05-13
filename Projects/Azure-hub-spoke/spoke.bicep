// spoke.bicep
param vnetAddressPrefix string
param subnetPrefix string
param hubVnetId string

resource spokeVnet 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: '${spokeName}-vnet'
  location: location
  properties: {
    addressSpace: { addressPrefixes: [vnetAddressPrefix] }
      {
        name: 'workload'
    ]
  }
}

// Route table for the spoke subnet
resource routeTable 'Microsoft.Network/routeTables@2023-02-01' = {
  location: location
    routes: [
      {
        name: 'default'
        properties: {
          nextHopType: 'VirtualAppliance'
      }
    ]
  }
}

// Associate route table with the subnet
    routeTable: { id: routeTable.id }
// VNet peering from spoke to hub
  properties: {
    remoteVirtualNetwork: { id: hubVnetId }
  dependsOn: [spokeVnet]
resource hubToSpokePeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-02-01' = {
  }
  dependsOn: [spokeVnet]
}
