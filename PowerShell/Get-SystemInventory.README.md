# Get-SystemInventory.ps1

## Purpose
Collects basic hardware, OS, BIOS, RAM, and boot information.

## Usage
```powershell
.\Get-SystemInventory.ps1
```

## Output
Exports a CSV report and displays the collected system information.

## Requirements
Windows PowerShell 5.1 or PowerShell 7+. Administrative rights may be required for some CIM information.

## Safety
Read-only inventory script. Do not store exported reports where sensitive device information is publicly accessible.
