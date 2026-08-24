[CmdletBinding()]
param(
    [string[]]$Name = @("w32time","WinRM","BITS","Spooler")
)

Get-Service -Name $Name -ErrorAction SilentlyContinue |
    Select-Object Name, DisplayName, Status, StartType
