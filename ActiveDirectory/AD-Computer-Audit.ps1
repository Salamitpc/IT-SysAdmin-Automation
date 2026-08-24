[CmdletBinding()]
param([int]$InactiveDays=90)
Import-Module ActiveDirectory
$cut=(Get-Date).AddDays(-$InactiveDays)
Get-ADComputer -Filter * -Properties LastLogonDate,OperatingSystem,Enabled,WhenCreated | Select-Object Name,DNSHostName,Enabled,OperatingSystem,LastLogonDate,WhenCreated,@{N='Inactive';E={$_.LastLogonDate -lt $cut -or !$_.LastLogonDate}}
