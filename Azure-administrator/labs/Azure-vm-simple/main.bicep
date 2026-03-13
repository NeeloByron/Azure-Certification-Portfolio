param location string = resourceGroup().location

var vnetName = 'vnet-${vmName}'
var publicIpName = 'pip-${vmName}'
var nsgName = 'nsg-${vmName}'
var nicName = 'nic-${vmName}'
var scriptName = 'configure-iis'
resource vnet 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    subnets: [
      {
    ]
  }

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-02-01' = {
    securityRules: [
        name: 'RDP'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          destinationAddressPrefix: '*'
          access: 'Allow'
        }
    ]
resource publicIp 'Microsoft.Network/publicIPAddresses@2023-02-01' = {
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-02-01' = {
  dependsOn: [
    vnet
    nsg
    publicIp
  ]
    ipConfigurations: [
        name: 'ipconfig1'
          subnet: {
            id: vnet.properties.subnets[0].id
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
          }
        }
      }
    ]
    networkSecurityGroup: {
    }
  }
}

  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
      }
    }
    networkProfile: {
      networkInterfaces: [
          id: nic.id
        }
      ]
    }
  }
}

resource customScript 'Microsoft.Compute/virtualMachines/extensions@2023-03-01' = {
  parent: vm
  name: scriptName
  location: location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/NeeloByron/Azure-Certification-Portfolio/main/Azure-administrator/Projects/azure-vm-simple/scripts/install-iis.ps1'
    }
  }
}

output vmPublicIp string = publicIp.properties.ipAddress

