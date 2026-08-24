[CmdletBinding()]
param([int]$Days=30)
Import-Module ActiveDirectory
$start=(Get-Date).AddDays(-$Days)
Get-ADUser -Filter * -Properties Enabled,WhenCreated,WhenChanged | Where-Object {$_.WhenCreated -ge $start -or $_.WhenChanged -ge $start} | Select-Object SamAccountName,Name,Enabled,WhenCreated,WhenChanged
