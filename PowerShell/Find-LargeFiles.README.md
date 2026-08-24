# Find-LargeFiles.ps1

## Purpose
Finds large files that may be consuming disk capacity.

## Usage
```powershell
.\Find-LargeFiles.ps1
.\Find-LargeFiles.ps1 -Path "D:\Data" -MinimumSizeMB 1000 -Top 25
```

## Safety
Read-only. Review results before deleting or moving files.
