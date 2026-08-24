[CmdletBinding()]
param([string]$OutputPath = ".\SystemInventory.csv")

$ErrorActionPreference = "Stop"
try {
    $os = Get-CimInstance Win32_OperatingSystem
    $cs = Get-CimInstance Win32_ComputerSystem
    $bios = Get-CimInstance Win32_BIOS
    $result = [pscustomobject]@{
        ComputerName = $env:COMPUTERNAME
        Manufacturer = $cs.Manufacturer
        Model = $cs.Model
        SerialNumber = $bios.SerialNumber
        OS = $os.Caption
        OSVersion = $os.Version
        Build = $os.BuildNumber
        Architecture = $os.OSArchitecture
        RAM_GB = [math]::Round($cs.TotalPhysicalMemory / 1GB, 2)
        LastBoot = $os.LastBootUpTime
    }
    $result | Export-Csv -Path $OutputPath -NoTypeInformation
    $result
}
catch { Write-Error "Inventory collection failed: $($_.Exception.Message)" }
