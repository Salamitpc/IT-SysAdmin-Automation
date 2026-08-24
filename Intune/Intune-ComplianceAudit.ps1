[CmdletBinding()]
param()
Connect-MgGraph -Scopes 'DeviceManagementManagedDevices.Read.All'
Get-MgDeviceManagementManagedDevice -All | Where-Object ComplianceState -ne 'compliant' | Select DeviceName,UserPrincipalName,ComplianceState,OperatingSystem,OSVersion,LastSyncDateTime,SerialNumber
