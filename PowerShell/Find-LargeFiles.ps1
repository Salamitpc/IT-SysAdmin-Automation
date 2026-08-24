[CmdletBinding()]
param(
    [string]$Path = "C:\",
    [int]$MinimumSizeMB = 500,
    [int]$Top = 50
)

$minBytes = $MinimumSizeMB * 1MB
Get-ChildItem -Path $Path -File -Recurse -Force -ErrorAction SilentlyContinue |
    Where-Object Length -ge $minBytes |
    Sort-Object Length -Descending |
    Select-Object -First $Top FullName,
        @{N="SizeMB";E={[math]::Round($_.Length/1MB,2)}},
        LastWriteTime
