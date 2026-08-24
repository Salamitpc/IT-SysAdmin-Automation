# Get-ServiceStatus.ps1

## Purpose
Checks status and startup configuration for selected Windows services.

## Usage
```powershell
.\Get-ServiceStatus.ps1
.\Get-ServiceStatus.ps1 -Name "WinRM","BITS"
```

## Safety
Read-only. The script does not start, stop, or modify services.
