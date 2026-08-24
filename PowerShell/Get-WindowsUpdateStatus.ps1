[CmdletBinding()]
param()

$hotfixes = Get-HotFix | Sort-Object InstalledOn -Descending
[pscustomobject]@{
    ComputerName = $env:COMPUTERNAME
    LastHotFix = $hotfixes | Select-Object -First 1 -ExpandProperty HotFixID
    LastInstalledOn = $hotfixes | Select-Object -First 1 -ExpandProperty InstalledOn
    HotFixCount = $hotfixes.Count
}
