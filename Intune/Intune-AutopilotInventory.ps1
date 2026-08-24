[CmdletBinding()]
param()
Connect-MgGraph -Scopes 'DeviceManagementServiceConfig.Read.All'
Get-MgDeviceManagementWindowsAutopilotDeviceIdentity -All | Select Id,DisplayName,SerialNumber,GroupTag,PurchaseOrderIdentifier,ProductKey,Manufacturer,Model,EnrollmentState
