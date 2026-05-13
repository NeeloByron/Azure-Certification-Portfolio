
// main.bicep - Multi‑tier App with VNet Integration, Private Endpoints, Monitoring

// Parameters
param appName string = 'webapp${uniqueString(resourceGroup().id)}'
param sqlServerName string = 'sqlserver${uniqueString(resourceGroup().id)}'
param adminUsername string = 'sqladmin'
@secure()
param adminPassword string

// VNet Configuration
param integrationSubnetPrefix string = '10.0.1.0/24'  // for App Service VNet integration
// App Service Plan (Premium V3 required for VNet integration with private endpoints)
// Log Analytics Workspace
param workspaceName string = 'logs-${uniqueString(resourceGroup().id)}'

// Application Insights
param appInsightsName string = 'appinsights-${appName}'

// Resources

// 1. Resource Group (already exists, so no need to create)
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
    retentionInDays: 30
      name: 'PerGB2018'
  }
}

// 3. Application Insights
    WorkspaceResourceId: logAnalytics.id
    Request_Source: 'rest'
  }
}

// 4. Virtual Network and Subnets
  name: 'vnet-full-app'
  location: location
      addressPrefixes: [vnetAddressPrefix]
    subnets: [
      {
        name: 'integration'
        properties: {
          addressPrefix: integrationSubnetPrefix
          delegations: [
            {
              name: 'Microsoft.Web.serverFarms'
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }
      {
        name: 'privateendpoint'
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
    ]
  }
}

// 5. SQL Server and Database
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
    version: '12.0'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  name: sqlDatabaseName
  location: location
    name: 'GP_S_Gen5_1'
    tier: 'GeneralPurpose'
  }
}

// 6. Private Endpoint for SQL
  location: location
  properties: {
      id: vnet.properties.subnets[1].id
    privateLinkServiceConnections: [
        name: 'sql-connection'
          privateLinkServiceId: sqlServer.id
          groupIds: ['sqlServer']
          requestMessage: 'Approval required'
        }
      }
    ]
  }
}

// 7. Private DNS Zone for SQL (and link to VNet)
}

resource sqlDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
}

resource sqlPrivateDnsRecord 'Microsoft.Network/privateDnsZones/A@2020-06-01' = {
  name: sqlServerName
    aRecords: [
      {
        ipv4Address: sqlPrivateEndpoint.properties.privateEndpointNetworkInterfaces[0].properties.ipConfigurations[0].properties.privateIPAddress
  dependsOn: [sqlPrivateEndpoint]
// 8. App Service Plan (Premium V3)
  }
  properties: {
    reserved: true
}

// 9. App Service (Web App)
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  properties: {
  }
  identity: {
    type: 'SystemAssigned'

// 10. App Insights connection string as app setting
  properties: {
    APPINSIGHTS_INSTRUMENTATIONKEY: appInsights.properties.InstrumentationKey
    APPLICATIONINSIGHTS_CONNECTION_STRING: appInsights.properties.ConnectionString
}

// 11. Diagnostic Settings for App Service
  name: 'diag-appservice'
  properties: {
        enabled: true
    ]
        enabled: true
    ]
  }
}
// Outputs
output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
output logAnalyticsWorkspace string = logAnalytics.name
