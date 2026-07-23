param location string = 'swedencentral'
param resourceGroupName string = 'rg-sre-poc'
param appName string = 'sre-poc-app'
var uniqueAppName = '${appName}-${uniqueString(resourceGroup().id)}'
param logAnalyticsName string = 'sre-poc-law'
param appInsightsName string = 'sre-poc-ai'
param planName string = 'sre-poc-plan'

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsName
  location: location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalytics.id
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: planName
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: uniqueAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appInsights.properties.ConnectionString
        }
      ]
    }
  }
}

resource actionGroup 'Microsoft.Insights/actionGroups@2022-06-01' = {
  name: 'sre-poc-ag'
  location: 'global'
  properties: {
    groupShortName: 'sreag'
    enabled: true
  }
}

resource metricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'high-cpu-alert'
  location: 'global'
  properties: {
    severity: 3
    enabled: true
    scopes: [
      webApp.id
    ]
    evaluationFrequency: 'PT1M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          criterionType: 'StaticThresholdCriterion'
          name: 'HighCPU'
          metricName: 'CpuTime'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Maximum'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroup.id
      }
    ]
  }
}
