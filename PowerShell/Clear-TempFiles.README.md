# Clear-TempFiles.ps1

## Purpose
Removes temporary files older than a selected number of days.

## Usage
Preview changes first:
```powershell
.\Clear-TempFiles.ps1 -OlderThanDays 7 -WhatIf
```
Then run after reviewing the preview:
```powershell
.\Clear-TempFiles.ps1 -OlderThanDays 7
```

## Safety
This script deletes files. Always use `-WhatIf` first and test in a lab before production use.
