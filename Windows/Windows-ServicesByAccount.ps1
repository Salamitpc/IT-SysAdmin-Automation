[CmdletBinding()]
param([string]$Account)
Get-CimInstance Win32_Service -ErrorAction SilentlyContinue | Where-Object {$_.StartName -and (!$Account -or $_.StartName -like "*$Account*")} | Select Name,DisplayName,State,StartMode,StartName,PathName
