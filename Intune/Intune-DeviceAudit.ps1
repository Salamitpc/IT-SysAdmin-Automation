[CmdletBinding()]
param([int]$StaleDays=30)
Connect-MgGraph -Scopes 'DeviceManagementManagedDevices.Read.All'
$cut=(Get-Date).AddDays(-$StaleDays)
Get-MgDeviceManagementManagedDevice -All | Select DeviceName,UserPrincipalName,OperatingSystem,OSVersion,ComplianceState,ManagementAgent,LastSyncDateTime,AzureADDeviceId,SerialNumber,@{N='Stale';E={$_.LastSyncDateTime -lt $cut}}
