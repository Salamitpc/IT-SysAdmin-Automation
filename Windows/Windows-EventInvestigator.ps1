[CmdletBinding()]
param([int]$Hours=24,[int]$MaxEvents=100)
$start=(Get-Date).AddHours(-$Hours)
Get-WinEvent -FilterHashtable @{LogName='System';Level=1,2,3;StartTime=$start} -MaxEvents $MaxEvents -ErrorAction SilentlyContinue | Select TimeCreated,Id,LevelDisplayName,ProviderName,MachineName,Message
