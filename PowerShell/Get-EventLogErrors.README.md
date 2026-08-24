# Get-EventLogErrors.ps1

## Purpose
Collects recent System event log errors for troubleshooting.

## Usage
```powershell
.\Get-EventLogErrors.ps1
.\Get-EventLogErrors.ps1 -Hours 48 -MaxEvents 200
```

## Safety
Read-only diagnostic script. Event messages can contain system or user details, so protect exported results appropriately.
