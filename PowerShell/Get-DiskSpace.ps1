[CmdletBinding()]
param([int]$MinimumFreePercent = 15)

Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" |
    Select-Object DeviceID,
        @{N="SizeGB";E={[math]::Round($_.Size/1GB,2)}},
        @{N="FreeGB";E={[math]::Round($_.FreeSpace/1GB,2)}},
        @{N="FreePercent";E={[math]::Round(($_.FreeSpace/$_.Size)*100,2)}} |
    ForEach-Object {
        $_ | Add-Member NoteProperty LowSpace ($_.FreePercent -lt $MinimumFreePercent) -PassThru
    }
