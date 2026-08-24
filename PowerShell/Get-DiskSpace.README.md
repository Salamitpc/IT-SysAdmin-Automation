# Get-DiskSpace.ps1

## Purpose
Reports local disk size, free space, free percentage, and whether a drive is below the configured threshold.

## Usage
```powershell
.\Get-DiskSpace.ps1
.\Get-DiskSpace.ps1 -MinimumFreePercent 20
```

## Safety
Read-only. Useful for endpoint health checks and proactive storage monitoring.
