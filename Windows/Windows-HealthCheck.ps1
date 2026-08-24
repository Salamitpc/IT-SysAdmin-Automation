[CmdletBinding()]
param([int]$DiskFreeThreshold=15)
$os=Get-CimInstance Win32_OperatingSystem
$cpu=(Get-CimInstance Win32_Processor | Measure-Object LoadPercentage -Average).Average
$mem=[math]::Round((1-($os.FreePhysicalMemory/$os.TotalVisibleMemorySize))*100,1)
$disks=Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | Select DeviceID,@{N='FreePercent';E={[math]::Round($_.FreeSpace/$_.Size*100,1)}}
[pscustomobject]@{Computer=$env:COMPUTERNAME;OS=$os.Caption;Build=$os.BuildNumber;CPUPercent=[math]::Round($cpu,1);MemoryUsedPercent=$mem;LastBoot=$os.LastBootUpTime;LowDisk=($disks|Where FreePercent -lt $DiskFreeThreshold|ForEach DeviceID) -join ', '}
