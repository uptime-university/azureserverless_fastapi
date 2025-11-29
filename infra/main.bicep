@description('Name of vm')
param vmName string = 'dev-server'

@description('Name of admin user')
param adminUsername string = 'devserver'

@secure()
@description('Admin password for the VM')
param adminPassword string

@description('Deployment region')
param location string = resourceGroup().location

@description('Vm size')
param vmSize string = 'Standard_B1s'

@description('data disksize')
param dataDiskSize int = 32

@description('config env')
var setupScript = loadTextContent('bash.sh')

// Ubuntu 22.04 LTS reference
var ubuntuImage = {
  publisher: 'Canonical'
  offer: '0001-com-ubuntu-server-jammy'
  sku: '22_04-lts'
  version: 'latest'
}

// Public IP
//
resource publicIP 'Microsoft.Network/publicIPAddresses@2023-02-01' = {
  name: '${vmName}-pip'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

// Virtual Network
//
resource vnet 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: '${vmName}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

// Network Interface
//
resource nic 'Microsoft.Network/networkInterfaces@2023-02-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
  }
}

// Virtual Machine
//
resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vmName
  location: location

  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }

    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }

    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }

    storageProfile: {
      // OS DISK
      osDisk: {
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }

      // UBUNTU IMAGE
      imageReference: ubuntuImage

      // DATA DISK
      dataDisks: [
        {
          lun: 0
          createOption: 'Empty'
          diskSizeGB: dataDiskSize
          managedDisk: {
            storageAccountType: 'Premium_LRS'
          }
        }
      ]
    }
  }
}

resource vmExtension 'Microsoft.Compute/virtualMachines/extensions@2023-03-01' = {
  name: '${vmName}/setupScript'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      commandToExecute: 'echo "${setupScript}" > setup.sh && chmod +x setup.sh && bash setup.sh'
    }
  }
  dependsOn: [
    vm
  ]
}

output vmId string = vm.id
output publicIPAddress string = reference(publicIP.id).ipAddress
