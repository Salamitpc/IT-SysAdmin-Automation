[CmdletBinding()]
param([string]$ComputerName=$env:COMPUTERNAME)
Invoke-Command -ComputerName $ComputerName -ScriptBlock {Get-LocalGroupMember -Group Administrators | Select Name,ObjectClass,PrincipalSource}
