# Get-InstalledSoftware.ps1

## Purpose
Inventories installed Windows applications using standard registry uninstall locations.

## Usage
```powershell
.\Get-InstalledSoftware.ps1
.\Get-InstalledSoftware.ps1 -Name "Microsoft"
```

## Safety
Read-only inventory. Results may include application names and versions that should be handled according to organizational data policies.
