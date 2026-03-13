param location string = resourceGroup().location
param adminUsername string
param adminPassword string @secure()
param enablePublicIP bool = false

var vnetName = 'vnet-avail'
var subnetName = 'default'
var nsgName = 'nsg-avail'
var availabilitySetName = 'availSet'
var scriptName = 'configure-iis'

resource vnet 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-02-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'RDP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
        }
      }
    ]
  }
}

resource availabilitySet 'Microsoft.Compute/availabilitySets@2023-03-01' = {
  name: availabilitySetName
  location: location
  properties: {
    platformFaultDomainCount: 2
    platformUpdateDomainCount: 5
  }
  sku: {
    name: 'Aligned'
  }
}

resource publicIPs 'Microsoft.Network/publicIPAddresses@2023-02-01' = [for i in range(0, vmCount): {
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}]

resource nics 'Microsoft.Network/networkInterfaces@2023-02-01' = [for i in range(0, vmCount): {
  name: 'nic-${vmNamePrefix}-${i}'
  location: location
  dependsOn: [
    vnet
    nsg
    publicIPs
  ]
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: enablePublicIP ? {
            id: publicIPs[i].id
          } : null
        }
      }
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}]

  name: '${vmNamePrefix}-${i}'
  location: location
  properties: {
      id: availabilitySet.id
    }
    hardwareProfile: {
      vmSize: vmSize
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    osProfile: {
      computerName: '${vmNamePrefix}-${i}'
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nics[i].id
        }
      ]
    }
  }
}]

resource customScripts 'Microsoft.Compute/virtualMachines/extensions@2023-03-01' = [for i in range(0, vmCount): {
  name: scriptName
  location: location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
      fileUris: [
        'https://raw.githubusercontent.com/NeeloByron/Azure-Certification-Portfolio/main/Azure-administrator/Projects/azure-vm-availability/scripts/install-iis.ps1'
      commandToExecute: 'powershell -ExecutionPolicy Unrestricted -File install-iis.ps1'
    }
  }
}]

output vmPrivateIPs array = [for i in range(0, vmCount): nics[i].properties.ipConfigurations[0].properties.privateIPAddress]
